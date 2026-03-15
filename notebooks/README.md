# Model Training Notebooks

This folder contains the Jupyter notebook used for training the crop disease classification model.

## 📓 Notebook: `crop_disease_classification_complete.ipynb`

This notebook contains the complete training pipeline for the ResNet50 model with 5-fold cross-validation.

### 📊 Contents

The notebook includes:

1. **Data Loading and Exploration**
   - Loading 2000 labeled images across 10 classes
   - Data visualization and class distribution analysis

2. **Data Preprocessing**
   - Image resizing to 224×224
   - Normalization using ImageNet statistics
   - Data augmentation techniques

3. **Model Architecture**
   - ResNet50 pretrained on ImageNet
   - Custom classifier head (2048→256→10)
   - Dropout layers for regularization

4. **Training Configuration**
   - 5-Fold Cross Validation
   - Batch size: 32
   - Optimizer: Adam (lr=0.001, weight decay=0.0001)
   - Loss function: CrossEntropyLoss
   - 6 epochs per fold

5. **Training Loop**
   - Per-fold training with validation
   - Loss and accuracy tracking
   - Model checkpointing

6. **Evaluation Metrics**
   - Per-class precision, recall, F1-score
   - Confusion matrix analysis
   - Training/validation curves

### 📈 Results

- **Average Training Accuracy**: 99.91%
- **Average Validation Accuracy**: 92.16%
- **Average Training Loss**: 0.0260
- **Average Validation Loss**: 0.1128

### 🚀 How to Use

```bash
# Install required packages
pip install torch torchvision matplotlib seaborn scikit-learn jupyter

# Launch Jupyter
jupyter notebook crop_disease_classification_complete.ipynb
📁 Output Files
The notebook generates:

Trained model weights (model.pth)

Training history CSV

Confusion matrix visualization

Per-class classification report

📌 Notes
The notebook assumes images are organized in class-wise folders

Training time: ~1.8 hours on GPU (CPU will be slower)

Model size: 98 MB