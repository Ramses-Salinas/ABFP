from fastapi import FastAPI

from app.api import predicciones

app = FastAPI(
    title="Módulo de Modelos IA - Predicciones",
    description="API para realizar predicciones con modelos de IA.",
    version="0.1.0",
)

app.include_router(predicciones.router, prefix="/predicciones")

@app.get("/health", tags=["Health"])
async def health_check():
    return {"status": "ok"}