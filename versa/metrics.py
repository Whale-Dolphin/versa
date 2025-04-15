#!/usr/bin/env python3

# Copyright 2025 Jiatong Shi
#  Apache 2.0  (http://www.apache.org/licenses/LICENSE-2.0)

STR_METRIC = [
    "vad_info",
    "language",
    "qwen_speaker_count",
    "qwen_speaker_gender",
    "qwen_speaker_age",
    "qwen_speech_impairment",
    "qwen_pitch_range",
    "qwen_voice_pitch",
    "qwen_voice_type",
    "qwen_speech_volume_level",
    "qwen_language",
    "qwen_speech_register",
    "qwen_vocabulary_complexity",
    "qwen_speech_purpose",
    "qwen_speech_emotion",
    "qwen_speech_clarity",
    "qwen_speech_rate",
    "qwen_speaking_style",
    "qwen_laughter_crying",
    "qwen_speech_background_environment",
    "qwen_overlapping_speech",
    "qwen_recording_quality",
    "qwen_channel_type",
    "ref_text",
    "espnet_hyp_text",
    "owsm_hyp_text",
    "whisper_hyp_text",
]

NUM_METRIC = [
    "dnsmos_overall",
    "dnsmos_p808",
    "nisqa",
    "utmos",
    "plcmos",
    "torch_squim_pesq",
    "torch_squim_stoi",
    "torch_squim_si_sdr",
    "singmos",
    "sheet_ssqa",
    "utmosv2",
    "scoreq_nr",
    "se_si_snr",
    "se_ci_sdr",
    "se_sar",
    "se_sdr",
    "pam",
    "srmr",
    "speaking_rate",
    "asvspoof_score",
    "audiobox_aesthetics_CE",
    "audiobox_aesthetics_CU",
    "audiobox_aesthetics_PC",
    "audiobox_aesthetics_PQ",
    "mcd",
    "f0_corr",
    "f0_rmse",
    "sir",
    "sar",
    "sdr",
    "ci-sdr",
    "si-snr",
    "pesq",
    "stoi",
    "speech_bert",
    "speech_belu",
    "speech_token_distance",
    "warpq",
    "scoreq_ref",
    "log_wmse",
    "asr_match_error_rate",
    "visqol",
    "pysepm_fwsegsnr",
    "pysepm_wss",
    "pysepm_cd",
    "pysepm_c_sig",
    "pysepm_c_bak",
    "pysepm_c_ovl",
    "pysepm_csii_high",
    "pysepm_csii_mid",
    "pysepm_csii_low",
    "pysepm_ncm",
    "noresqa",
    "torch_squim_mos",
    "espnet_wer",
    "espnet_wer_delete",
    "espnet_wer_insert",
    "espnet_wer_replace",
    "espnet_wer_equal",
    "espnet_cer",
    "espnet_cer_delete",
    "espnet_cer_insert",
    "espnet_cer_replace",
    "espnet_cer_equal",
    "owsm_wer",
    "owsm_wer_delete",
    "owsm_wer_insert",
    "owsm_wer_replace",
    "owsm_wer_equal",
    "owsm_cer",
    "owsm_cer_delete",
    "owsm_cer_insert",
    "owsm_cer_replace",
    "owsm_cer_equal",
    "whisper_wer",
    "whisper_wer_delete",
    "espnet_wer_insert",
    "espnet_wer_replace",
    "espnet_wer_equal",
    "whisper_cer",
    "whisper_cer_delete",
    "espnet_cer_insert",
    "espnet_cer_replace",
    "espnet_cer_equal",
    "emotion_similarity",
    "spk_similarity",
    "nomad",
    "clap_score",
    "apa",
    "pysepm_llr",
]
