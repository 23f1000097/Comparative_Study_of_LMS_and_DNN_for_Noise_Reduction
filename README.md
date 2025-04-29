Comparative Study of LMS and DNN for Noise Reduction
📌 Project Overview
This project explores and compares two approaches for real-time background noise reduction in speech recordings:

LMS (Least Mean Squares) Adaptive Filtering

Deep Neural Networks (DNNs) trained on MFCC features

Our goal was to evaluate how traditional adaptive filters perform against modern deep learning-based methods in removing noise while preserving speech clarity.

🎯 Objectives
Implement LMS algorithm for adaptive noise cancellation using MATLAB

Develop a DNN model in Python using Google Colab to denoise speech via supervised learning

Compare the performance of both methods using visual/audio outputs and quantitative analysis

Explore real-world applications in voice assistants, telemedicine, video conferencing, and more

🛠️ Technologies Used
MATLAB – For LMS filtering and real-time signal processing

Python (Google Colab) – For training and testing the DNN

Libraries: NumPy, TensorFlow/Keras, librosa, matplotlib

Feature Extraction: MFCC (Mel-Frequency Cepstral Coefficients)

📈 Methodology
🔹 LMS Algorithm (MATLAB)
Audio Input: Speech signal mixed with background noise

Preprocessing: High-pass filtering & silence detection

Adaptive Filtering: LMS updates weights in real-time

Post-processing: Amplification and normalization

🔹 DNN Approach (Python)
Dataset: Noisy speech = Clean speech + background noise

Feature Extraction: Convert audio to MFCCs

Model Training: DNN learns mapping from noisy → clean MFCCs

Prediction: Clean speech is reconstructed from predicted MFCCs

📊 Results
LMS: Fast and efficient for real-time use with consistent noise suppression

DNN: More accurate noise removal in complex conditions but needs more data and training time

✅ LMS Output (MATLAB)
Graphs showing noise levels before and after filtering

Audio samples for comparison

✅ DNN Output (Python)
Spectrograms of noisy vs. denoised speech

Predicted clean waveforms and loss graphs
