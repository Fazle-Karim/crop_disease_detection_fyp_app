from fastapi import FastAPI, File, UploadFile
from fastapi.middleware.cors import CORSMiddleware
import torch
import torch.nn.functional as F
from torchvision import transforms
from PIL import Image
import io
import os

# -----------------------------
# PATHS
# -----------------------------
MODEL_PATH = r"C:\Users\PMYLS\Desktop\FYP mid term\fyp_data\model.pth"
TRAIN_DIR  = r"C:\Users\PMYLS\Desktop\FYP mid term\fyp_data\train"

CLASS_NAMES = sorted(os.listdir(TRAIN_DIR))
DEVICE = torch.device("cuda" if torch.cuda.is_available() else "cpu")

# -----------------------------
# APP
# -----------------------------
app = FastAPI(title="FYP AI API")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# -----------------------------
# LOAD MODEL
# -----------------------------
model = torch.load(MODEL_PATH, map_location=DEVICE, weights_only=False)
model.eval()

# -----------------------------
# TRANSFORM
# -----------------------------
transform = transforms.Compose([
    transforms.Resize((224, 224)),
    transforms.ToTensor(),
    transforms.Normalize(
        mean=[0.485, 0.456, 0.406],
        std=[0.229, 0.224, 0.225]
    )
])

# -----------------------------
# API ENDPOINT
# -----------------------------
@app.post("/predict")
async def predict(file: UploadFile = File(...)):
    image_bytes = await file.read()
    image = Image.open(io.BytesIO(image_bytes)).convert("RGB")

    img_tensor = transform(image).unsqueeze(0).to(DEVICE)

    with torch.no_grad():
        outputs = model(img_tensor)
        probs = F.softmax(outputs, dim=1)
        confidence, predicted_class = torch.max(probs, 1)

    class_name = CLASS_NAMES[predicted_class.item()]
    confidence_score = float(confidence.item() * 100)

    probabilities = {
        CLASS_NAMES[i]: float(probs[0][i])
        for i in range(len(CLASS_NAMES))
    }

    return {
        "prediction": class_name,
        "confidence": round(confidence_score, 2),
        "probabilities": probabilities
    }