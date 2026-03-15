# Dataset Information

This folder contains information about the dataset used for training the crop disease detection model.

## 📊 Dataset Overview

- **Total Images**: 2000 labeled images
- **Number of Classes**: 10
- **Crops Covered**: Maize, Potato, Tomato
- **Image Format**: RGB (224×224 after preprocessing)

## 📁 Dataset Structure

The dataset is organized in the following structure:
dataset/
├── train/
│ ├── Maize_Common_rust/
│ ├── Maize_healthy/
│ ├── Maize_Northern_Leaf_Blight/
│ ├── Maize_Northern_Leaf_Blight_1/
│ ├── Potato_Early_blight/
│ ├── Potato_healthy/
│ ├── Potato_Late_blight/
│ ├── Tomato_Cercospora_leaf_spot_Gray_leaf_spot/
│ ├── Tomato_healthy/
│ └── Tomato_Late_blight/
└── test/ (optional)
├── Maize_Common_rust/
└── ...

text

## 🖼️ Class Details

| Crop | Class Name | Condition | Sample Count |
|------|------------|-----------|--------------|
| **Maize** | Maize_Common_rust | Common Rust | ~200 |
| | Maize_healthy | Healthy | ~200 |
| | Maize_Northern_Leaf_Blight | Northern Leaf Blight | ~200 |
| | Maize_Northern_Leaf_Blight_1 | Northern Leaf Blight (Variant) | ~200 |
| **Potato** | Potato_Early_blight | Early Blight | ~200 |
| | Potato_healthy | Healthy | ~200 |
| | Potato_Late_blight | Late Blight | ~200 |
| **Tomato** | Tomato_Cercospora_leaf_spot_Gray_leaf_spot | Cercospora/Gray Leaf Spot | ~200 |
| | Tomato_healthy | Healthy | ~200 |
| | Tomato_Late_blight | Late Blight | ~200 |


## 📝 Data Preprocessing

The following preprocessing steps were applied:

1. **Resizing**: All images resized to 224×224 pixels
2. **Normalization**: Mean and standard deviation normalization using ImageNet statistics:
   - Mean: [0.485, 0.456, 0.406]
   - Std: [0.229, 0.224, 0.225]
3. **Data Augmentation** (during training):
   - Random horizontal flips
   - Random rotations (±10 degrees)
   - Color jittering

## ⚠️ Note

The actual image files are **not included** in this repository due to size limitations. To use this project:

1. Download the dataset from [source link]
2. Organize images in the structure shown above
3. Update the `TRAIN_DIR` path in `backend/api.py` to point to your dataset location

## 📊 Dataset Statistics

- **Training/Validation Split**: 80/20 (per fold in 5-fold CV)
- **Class Balance**: Approximately balanced across all 10 classes
- **Image Resolution**: Variable (resized to 224×224 during preprocessing)