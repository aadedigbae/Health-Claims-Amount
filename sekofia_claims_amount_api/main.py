# 1. Import necessary libraries
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field
import joblib
import pandas as pd
import numpy as np

# 2. Create FastAPI instance
app = FastAPI(
    title="Sekofia Insurance Claims Predictor",
    description="API for predicting insurance claim amounts",
    version="1.0.0"
)

# 3. Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Allows all origins
    allow_credentials=True,
    allow_methods=["*"],  # Allows all methods
    allow_headers=["*"],  # Allows all headers
)

# 4. Define input data validation model
class InsuranceClaim(BaseModel):
    # Required numeric fields with validation
    PatientAge: int = Field(..., ge=0, le=120, description="Patient age (0-120 years)")
    PatientIncome: float = Field(..., ge=0, description="Annual income (>= 0)")
    
    # Required string fields with validation
    PatientGender: str = Field(..., pattern="^[MF]$", description="M or F")
    ProviderSpecialty: str = Field(..., description="Medical specialty")
    ClaimStatus: str = Field(..., description="Current claim status")
    PatientMaritalStatus: str = Field(..., description="Marital status")
    PatientEmploymentStatus: str = Field(..., description="Employment status")
    ProviderLocation: str = Field(..., description="Provider location")
    ClaimType: str = Field(..., description="Type of claim")
    ClaimSubmissionMethod: str = Field(..., description="Submission method")
    DiagnosisCode: str = Field(..., description="Diagnosis code")
    ProcedureCode: str = Field(..., description="Procedure code")

    # Add an example for Swagger UI
    class Config:
        schema_extra = {
            "example": {
                "PatientAge": 35,
                "PatientIncome": 75000.0,
                "PatientGender": "M",
                "ProviderSpecialty": "Cardiology",
                "ClaimStatus": "Pending",
                "PatientMaritalStatus": "Married",
                "PatientEmploymentStatus": "Employed",
                "ProviderLocation": "Jameshaven",
                "ClaimType": "Routine",
                "ClaimSubmissionMethod": "Online",
                "DiagnosisCode": "yy006",
                "ProcedureCode": "hd662"
            }
        }

# 5. Load the trained model
try:
    model = joblib.load('best_insurance_claim_model.joblib')
except Exception as e:
    print(f"Error loading model: {e}")
    # In production, you might want to handle this differently

# 6. Define prediction endpoint
@app.post("/predict")
async def predict_claim(claim: InsuranceClaim):
    try:
        # Convert input data to DataFrame
        input_data = pd.DataFrame([claim.dict()])
        
        # Make prediction
        prediction = model.predict(input_data)
        
        # Return prediction
        return {
            "status": "success",
            "predicted_claim_amount": float(prediction[0]),
            "currency": "USD"
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

# 7. Add a root endpoint
@app.get("/")
async def root():
    return {"message": "Welcome to Sekofia Insurance Claims Predictor API"}

# 8. Run the application
if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)