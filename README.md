<h1>Project Overview</h1>
The insurance claim amount predictor app streamlines healthcare insurance processes by providing automated claims processing, easy patient verification, and claims monitoring. This project implements a machine learning model to predict insurance claim amounts based on various patient and provider factors.

<h1>Dataset Description</h1>
The Health Insurance Claims dataset (source: Kaggle) contains comprehensive insurance claims data including:
<ul>Patient demographics (age, gender, income, marital status, employment status)
<ul>Provider information (specialty, location)
<ul>Claim details (amount, type, status, submission method)
<ul>Medical coding (diagnosis codes, procedure codes)

The dataset contains rich information with multiple features making it suitable for predictive modeling in the insurance domain.

Project Structure
linear_regression_model/
│  
├── README.md
├── enhanced_health_insurance_claims.csv
├── Insurance_Claim_Amount_Prediction.ipynb
│   
├── sekofia_claims_amount_api/
│   ├── venv/
│   ├── best_insurance_claim_model.joblib
│   ├── main.py
│   └── requirements.txt
│   
└── FlutterApp/

<h1>Model Implementation</h1>
The project implements and compares three different models:

Linear Regression
Decision Trees
Random Forest

Key visualizations include:

Correlation heatmap of numerical features
Distribution analysis of claim amounts
Scatter plots showing relationships between variables
Final linear regression fit visualization

<h1>API Documentation</h1>
The API is deployed and publicly available at:
Copyhttps://sekofia-api.onrender.com
Swagger UI Documentation: https://sekofia-api.onrender.com/docs
API Endpoints:

GET /: Welcome message
POST /predict: Predicts insurance claim amount

Example API Request:
jsonCopy{
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


<h1>Mobile App Setup</h1>
Prerequisites

Flutter SDK (version 3.0 or higher)
Android Studio or VS Code with Flutter extensions
Android/iOS emulator or physical device

Installation Steps

Clone the repository:

bash git clone https://github.com/yourusername/sekofia-claims-predictor.git

Navigate to the Flutter app directory:

bash cd insurance_claim_amount_prediction_app

Install dependencies:

bash flutter pub get

Run the app:

bash flutter run
Using the App

Launch the app
Fill in all required fields:

Patient Age
Patient Income
Patient Gender (M/F)
Provider Specialty
Claim Status
Other required fields


Tap the "Predict" button
View the predicted claim amount

<h1>Demo Video</h1>
Watch the demonstration of the project here: YouTube Demo Link

<h1>Technologies Used</h1>
Python (Scikit-learn, Pandas, NumPy)
FastAPI
Flutter
Render (for API deployment)

<h1>Contributors</h1>
Adedigba Adediwura
