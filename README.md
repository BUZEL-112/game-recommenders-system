# Game Recommendation System 

> ML-powered Steam game recommendation engine — personalized, scalable, production-ready.

[![Ask DeepWiki](https://deepwiki.com/badge.svg)](https://deepwiki.com/FAKER-112/game-recommenders-system)

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Usage Guide](#usage-guide)
- [API Documentation](#api-documentation)
- [Configuration](#configuration)
- [Development](#development)
- [Deployment](#deployment)
- [Contributing](#contributing)

## Overview

RSgame-system is a multi-model recommendation system that analyzes user–game interaction data from Steam to deliver accurate, personalized suggestions. It supports three complementary machine learning strategies:

1. **Autoencoder** — Content-based recommendations derived from game features (genres, tags)
2. **Matrix Factorization** — Collaborative filtering built on user–item interaction patterns
3. **TFRS (TensorFlow Recommenders)** — Scalable two-tower retrieval for large catalogs

## Features

**Multiple Recommendation Strategies**
- User-based collaborative filtering (Matrix Factorization, TFRS)
- Item-based content similarity (Autoencoder)
- Hybrid recommendation approaches

**Complete ML Pipeline**
- Automated data ingestion from public Steam datasets
- Feature engineering and preprocessing
- Model training with MLflow experiment tracking
- Comprehensive evaluation metrics

**Production-Ready API**
- RESTful Flask API with CORS support
- Batch recommendation endpoints
- Pagination and search functionality
- Health monitoring and structured error handling

**Experiment Tracking**
- MLflow integration for all training runs
- Hyperparameter logging and metric visualization

**Containerization**
- Docker support for consistent deployment

## Project Structure

```
RSgame-system/
├── app.py                          # Flask API server
├── requirements.txt                # Python dependencies
├── configs/
│   ├── config.yaml                 # Data pipeline config
│   ├── model_params.yaml           # Model hyperparameters
│   └── pipeline_params.yaml        # Pipeline orchestration
├── src/
│   ├── data/
│   │   ├── load_data.py            # Data ingestion
│   │   ├── clean_data.py           # Data cleaning
│   │   └── feature_engineering.py  # Feature creation
│   ├── models/
│   │   ├── build_model.py          # Model architectures
│   │   ├── train_model.py          # Training logic
│   │   └── evaluate_model.py       # Evaluation metrics
│   ├── pipeline/
│   │   ├── train_pipeline.py       # End-to-end training
│   │   ├── predict_pipeline.py     # Inference engine
│   │   └── evaluate_pipeline.py    # Model evaluation
│   └── utils/
│       ├── logger.py               # Logging configuration
│       └── exception.py            # Custom exceptions
├── data/
│   ├── raw/                        # Raw downloaded data
│   └── processed/                  # Processed datasets
├── artifacts/
│   ├── models/                     # Trained models
│   └── context/                    # Encoders and vocabularies
├── mlruns/                         # MLflow experiment logs
├── notebooks/                      # Jupyter notebooks
├── templates/                      # HTML templates
└── static/                         # Static assets
```

## Prerequisites

- **Python** 3.8 or higher
- **pip** package manager
- **Git**
- **Disk Space** ~5 GB for datasets and models
- **RAM** Minimum 8 GB (16 GB recommended for training)
- **GPU** Optional but recommended for TFRS training

## Installation

### 1. Clone the repository

```bash
git clone <repository-url>
cd RSgame-system
```

### 2. Create a virtual environment

```bash
python -m venv venv
source venv/bin/activate        # Linux / macOS
venv\Scripts\activate           # Windows
```

### 3. Install dependencies

```bash
pip install -r requirements.txt
```

### 4. Verify installation

```bash
python -c "import tensorflow as tf; print(f'TensorFlow: {tf.__version__}')"
python -c "import tensorflow_recommenders as tfrs; print('TFRS ready')"
```

## Quick Start

### Option 1 — Use pre-trained models

```bash
python app.py
```

The API will be available at `http://localhost:5000`.

### Option 2 — Train from scratch

```bash
# Full pipeline (30–60 min)
python src/pipeline/train_pipeline.py

# Evaluate
python src/pipeline/evaluate_pipeline.py

# Serve
python app.py
```

### Option 3 — Step-by-step

```bash
python -c "from src.data.load_data import LoadDataService; LoadDataService().run()"
python -c "from src.data.clean_data import CleanDataService; CleanDataService().run()"
python -c "from src.data.feature_engineering import FeatureEngineeringService; FeatureEngineeringService().run()"
python -c "from src.models.train_model import ModelTrainingService; ModelTrainingService(model_type='tfrs').run()"
python -c "from src.models.evaluate_model import ModelEvaluationService; ModelEvaluationService(model_type='tfrs').run()"
```

## Usage Guide

### Training

```python
from src.pipeline.train_pipeline import TrainingPipeline

TrainingPipeline(model_type='matrix_factorization').train_model()
TrainingPipeline(model_type='tfrs').train_model()
TrainingPipeline(model_type='autoencoder').train_model()
```

### Inference

```python
from src.pipeline.predict_pipeline import PredictionPipeline

predictor = PredictionPipeline(model_type='tfrs')

# Personalized recommendations
recs = predictor.recommend(user_id='76561197970982479', n_rec=10)

# Content similarity
similar = predictor.get_similar_items(item_name='Counter-Strike', k=5)
```

### REST API

```bash
# User recommendations
curl -X POST http://localhost:5000/recommend_user \
  -H "Content-Type: application/json" \
  -d '{"model_name": "tfrs", "user_id": "76561197970982479", "n_rec": 10}'

# Item similarity
curl -X POST http://localhost:5000/recommend_item \
  -H "Content-Type: application/json" \
  -d '{"model_name": "autoencoder", "item_name": "Counter-Strike", "k": 5}'
```

## API Documentation

### Base URL

```
http://localhost:5000
```

### Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/health` | Server and model status |
| GET | `/api/userlist` | All available user IDs |
| GET | `/api/gamedata` | Paginated game catalog |
| GET | `/api/game/<id>` | Single game detail |
| POST | `/recommend_user` | User-based recommendations |
| POST | `/recommend_item` | Item similarity search |
| POST | `/batch_recommend` | Batch recommendations |
| GET | `/model_info/<name>` | Model metadata |
| GET | `/available_models` | Loaded model status |

### Health check

```json
{
  "status": "healthy",
  "models_loaded": ["tfrs"],
  "data_loaded": {"games": true, "users": true}
}
```

### User recommendations

**Request**
```json
{
  "model_name": "tfrs",
  "user_id": "76561197970982479",
  "n_rec": 10
}
```

**Response**
```json
{
  "status": "success",
  "user_id": "76561197970982479",
  "model_used": "tfrs",
  "recommendations": ["Game A", "Game B"],
  "recommendations_with_details": [{ ... }],
  "count": 10
}
```

### Item similarity

**Request**
```json
{
  "model_name": "autoencoder",
  "item_name": "Counter-Strike",
  "k": 5
}
```

### Batch recommendations

**Request**
```json
{
  "model_name": "tfrs",
  "user_ids": ["user1", "user2", "user3"],
  "n_rec": 10
}
```

## Configuration

### `configs/model_params.yaml`

```yaml
model_params:
  autoencoder:
    encoding_dim: 64
    hidden_layers: [512, 256]

  matrix_factorization:
    embedding_size: 50
    hidden_layers: [512, 256]

  tfrs:
    embedding_size: 50
    hidden_layers: [512, 256]
```

### `configs/config.yaml`

```yaml
data_ingestion:
  user_item_dataset_download_url: "<URL>"
  raw_data_dir: "data/raw"
```

## Development

```bash
# Tests
python -m pytest tests/

# Coverage
python -m pytest --cov=src tests/

# Formatting
black src/

# Linting
flake8 src/
```

## Deployment

### Docker

```bash
docker build -t RSgame-system:latest .
docker run -p 5000:5000 RSgame-system:latest
```

### Production (Gunicorn)

```bash
pip install gunicorn
gunicorn -w 4 -b 0.0.0.0:5000 app:app
```

### AWS ECS (Terraform)

```bash
cd deployment/terraform
terraform init
terraform apply
```

## Model Comparison

| Model | Use Case | Avg. Latency | Best For |
|-------|----------|-------------|----------|
| **TFRS** | User recommendations | ~1–5 ms | Large-scale retrieval, known users |
| **Matrix Factorization** | User recommendations | ~5–20 ms | Personalized ranking |
| **Autoencoder** | Item similarity | ~10–50 ms | Content-based, cold-start items |

## Troubleshooting

**Models not loading**
```bash
python src/pipeline/train_pipeline.py
```

**Data not found**
```bash
python -c "from src.data.load_data import LoadDataService; LoadDataService().run()"
```

**Port already in use**
```bash
lsof -i :5000        # Linux / macOS
netstat -ano | findstr :5000  # Windows
```

**Out of memory during training** — reduce `batch_size` or `hidden_layers` in `configs/model_params.yaml`.

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/your-feature`)
3. Commit your changes (`git commit -m 'Add your feature'`)
4. Push to the branch (`git push origin feature/your-feature`)
5. Open a Pull Request

## License

MIT License — see [LICENSE](LICENSE) for details.

## Acknowledgments

- **Dataset** — Steam data from [UCSD McAuley Lab](https://cseweb.ucsd.edu/~jmcauley/)
- **Framework** — TensorFlow and TensorFlow Recommenders
- **Experiment Tracking** — MLflow

---

Built with TensorFlow, Flask, and MLflow.
