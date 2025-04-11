#!/usr/bin/env python3

# Copyright 2024 Jiatong Shi
#  Apache 2.0  (http://www.apache.org/licenses/LICENSE-2.0)

"""Module for discrete speech metrics evaluation."""

import logging

import librosa
import numpy as np

try:
    from discrete_speech_metrics import SpeechBERTScore, SpeechBLEU, SpeechTokenDistance
except ImportError:
    raise ImportError("Please install discrete_speech_metrics and retry")

logger = logging.getLogger(__name__)


def discrete_speech_setup(use_gpu=False):
    """Set up discrete speech metrics.

    Args:
        use_gpu (bool, optional): Whether to use GPU. Defaults to False.

    Returns:
        dict: Dictionary containing the initialized metrics.
    """
    # NOTE(jiatong) existing discrete speech metrics only works for 16khz
    # We keep the paper best setting. To use other settings, please conduct the
    # test on your own.

    speech_bert = SpeechBERTScore(
        sr=16000, model_type="wavlm-large", layer=14, use_gpu=use_gpu
    )
    speech_bleu = SpeechBLEU(
        sr=16000,
        model_type="hubert-base",
        vocab=200,
        layer=11,
        n_ngram=2,
        remove_repetition=True,
        use_gpu=use_gpu,
    )
    speech_token_distance = SpeechTokenDistance(
        sr=16000,
        model_type="hubert-base",
        vocab=200,
        layer=6,
        distance_type="jaro-winkler",
        remove_repetition=False,
        use_gpu=use_gpu,
    )
    return {
        "speech_bert": speech_bert,
        "speech_bleu": speech_bleu,
        "speech_token_distance": speech_token_distance,
    }


def discrete_speech_metric(discrete_speech_predictors, pred_x, gt_x, fs):
    """Calculate discrete speech metrics.

    Args:
        discrete_speech_predictors (dict): Dictionary of speech metrics.
        pred_x (np.ndarray): Predicted audio signal.
        gt_x (np.ndarray): Ground truth audio signal.
        fs (int): Sampling rate.

    Returns:
        dict: Dictionary containing the metric scores.

    Raises:
        NotImplementedError: If an unsupported metric is provided.
    """
    scores = {}

    if fs != 16000:
        gt_x = librosa.resample(gt_x, orig_sr=fs, target_sr=16000)
        pred_x = librosa.resample(pred_x, orig_sr=fs, target_sr=16000)

    for key in discrete_speech_predictors.keys():
        if key == "speech_bert":
            score, _, _ = discrete_speech_predictors[key].score(gt_x, pred_x)
        elif key == "speech_bleu" or key == "speech_token_distance":
            score = discrete_speech_predictors[key].score(gt_x, pred_x)
        else:
            raise NotImplementedError(f"Not supported {key}")
        scores[key] = score
    return scores


if __name__ == "__main__":
    a = np.random.random(16000)
    b = np.random.random(16000)
    predictor = discrete_speech_setup()
    print(discrete_speech_metric(predictor, a, b, 16000))
