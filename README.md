
# Crop Disease Detection System

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

An end-to-end crop disease detection system using deep learning. The project includes model training with **5-fold cross-validation**, FastAPI backend, and Flutter mobile app for real-time disease identification through leaf images.

## 📋 Project Overview

This system helps farmers and agricultural experts quickly identify crop diseases through simple leaf photographs. The model achieves **92.16% validation accuracy** using ResNet50 with transfer learning.

| Component | Technology | Purpose |
|-----------|------------|---------|
| **Deep Learning Model** | ResNet50 (PyTorch) | Classifies 10 disease/health conditions with 5-fold CV |
| **Backend API** | FastAPI | Serves the trained model for inference |
| **Mobile App** | Flutter | Captures leaf images and displays predictions |

## 🎯 Key Features

- ✅ **92.16% validation accuracy** with 5-fold cross-validation
- ✅ **10 disease classes** across maize, potato, and tomato crops
- ✅ **Transfer learning** with ResNet50 pretrained on ImageNet
- ✅ **Dropout layers** to prevent overfitting
- ✅ Real-time prediction with confidence scores
- ✅ Color-coded confidence indicators
- ✅ Low confidence guidance suggestions
- ✅ Cross-platform mobile app
- ✅ RESTful API for easy integration

## 📊 Dataset Classes

The dataset contains **2000 labeled images** of crop leaves across 10 classes:

| Crop | Class Name | Condition |
|------|------------|-----------|
| **Maize** | Maize_Common_rust | Common Rust |
| | Maize_healthy | Healthy |
| | Maize_Northern_Leaf_Blight | Northern Leaf Blight |
| | Maize_Northern_Leaf_Blight_1 | Northern Leaf Blight (Variant) |
| **Potato** | Potato_Early_blight | Early Blight |
| | Potato_healthy | Healthy |
| | Potato_Late_blight | Late Blight |
| **Tomato** | Tomato_Cercospora_leaf_spot_Gray_leaf_spot | Cercospora/Gray Leaf Spot |
| | Tomato_healthy | Healthy |
| | Tomato_Late_blight | Late Blight |

## 🏗️ Model Architecture

The model uses **ResNet-50** with transfer learning:

- **Base Model**: ResNet50 pre-trained on ImageNet
- **Custom Classifier**: Replaced final layer with two fully connected layers:
  - Layer 1: 2048 → 256 (with ReLU activation)
  - Layer 2: 256 → 10 (output classes)
  - **Dropout** added to prevent overfitting
- **Input Size**: 224×224×3 RGB images
- **Output**: 10 classes with Softmax activation

## ⚙️ Training Configuration

| Parameter | Value |
|-----------|-------|
| **Batch Size** | 32 |
| **Loss Function** | CrossEntropyLoss |
| **Optimizer** | Adam |
| **Learning Rate** | 0.001 |
| **Weight Decay** | 0.0001 |
| **Cross Validation** | 5-Fold |
| **Epochs per Fold** | 6 |

## 📈 Model Performance

### Overall Metrics (5-Fold Cross Validation)

| Metric | Value |
|--------|-------|
| **Average Training Accuracy** | 99.91% |
| **Average Validation Accuracy** | **92.16%** |
| **Average Training Loss** | 0.0260 |
| **Average Validation Loss** | 0.1128 |

### Key Observations

- ✅ **High training accuracy (99.9%)** indicates successful feature learning
- ✅ **Strong validation accuracy (92.16%)** shows good generalization
- ⚠️ **Small gap** between training and validation suggests mild overfitting
- ✅ **Dropout layers** effectively reduce overfitting

## 🏗️ Project Structure
crop_disease_detection_fyp_app/
├── backend/ # FastAPI server
│ ├── api.py # Main API with model inference
│ ├── requirements.txt # Python dependencies
│ └── README.md # Backend documentation
├── frontend/ # Flutter mobile app
│ ├── lib/ # Dart source code
│ ├── android/ # Android-specific files
│ ├── ios/ # iOS-specific files
│ └── pubspec.yaml # Flutter dependencies
├── notebooks/ # Jupyter notebooks
│ └── crop_disease_classification_complete.ipynb
├── models/ # Trained model weights
│ └── model.pth # ResNet50 model
├── docs/ # Additional documentation
├── data/ # Dataset information
├── .gitignore # Git ignore rules
├── .gitattributes # Git LFS configuration
├── LICENSE # MIT License
└── README.md # This file

text

## 🚀 Quick Start Guide

### Prerequisites

- **Python 3.8+** for backend
- **Flutter SDK** for mobile app
- **Android Studio / VS Code** for development
- **Git LFS** (for model file)

### 1. Backend Setup

```bash
# Navigate to backend folder
cd backend

# Create virtual environment
python -m venv venv
venv\Scripts\activate     # Windows

# Install dependencies
pip install -r requirements.txt

# Start the server
uvicorn api:app --reload --host 0.0.0.0 --port 8000
The API will be available at http://localhost:8000

Interactive docs: http://localhost:8000/docs

2. Frontend Setup
bash
# Navigate to frontend folder
cd frontend

# Get Flutter dependencies
flutter pub get

# Run the app
flutter run
3. Model Training (Optional)
bash
# Navigate to notebooks folder
cd notebooks

# Launch Jupyter
jupyter notebook crop_disease_classification_complete.ipynb
📱 App Features
Image Upload
Select images from gallery

Capture photos with camera

Image preview with zoom

Prediction Display
Primary prediction with large text

Confidence bar with color coding:

🟢 Green (80-100%): High confidence

🟠 Orange (60-79%): Medium confidence

🔴 Red (<60%): Low confidence

Confidence percentage with matching color

🛠️ Technologies Used
Area	Technologies
Deep Learning	PyTorch, torchvision, ResNet50
Backend	FastAPI, Uvicorn, Python
Frontend	Flutter, Dart
Development	Jupyter, VS Code, Git
📊 API Endpoints
POST /predict
Upload a leaf image for disease classification.

Response:

json
{
  "prediction": "Tomato_Late_blight",
  "confidence": 92.16,
  "probabilities": {
    "Tomato_Late_blight": 0.9216,
    "Tomato_healthy": 0.042,
    "Tomato_Cercospora_leaf_spot_Gray_leaf_spot": 0.036
  }
}
🔬 Discussion
The experimental results demonstrate that the proposed system effectively identifies crop diseases from leaf images:

Strengths
High training accuracy (99.9%) confirms successful feature learning

Strong validation accuracy (92.16%) indicates good generalization

5-fold cross-validation ensures robust evaluation

Challenges
Some confusion between visually similar disease variants

Performance may decrease with blurry or poorly lit images

Future Improvements
Expand dataset with more diverse images

Experiment with other architectures

Implement data augmentation

👨‍💻 Author
Fazle Karim

📧 Email: fazlekarim917@gmail.com

🐙 GitHub: @Fazle-Karim

📄 License
This project is licensed under the MIT License - see the LICENSE file for details.

🙏 Acknowledgments
Dataset: 2000 labeled crop leaf images across 10 classes

ResNet50: Pre-trained on ImageNet

FYP Supervisor: Dr. Hammood Ur Rehman Durrani



Model Accuracy: 92.16% (5-Fold Cross Validation)
