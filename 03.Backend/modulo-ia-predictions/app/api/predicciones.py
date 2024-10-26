from fastapi import APIRouter, Depends

from app.dominio.servicio_predicciones import ServicioPredicciones
from app.infraestructura.repositorios.repositorio_datos import RepositorioDatos

router = APIRouter()

def obtener_servicio_predicciones():
    repositorio = RepositorioDatos()  # Crear una instancia de RepositorioDatos
    return ServicioPredicciones(repositorio)  # Pasar la instancia al constructor

@router.post("/predecir", tags=["Predicciones"])
async def predecir(datos_entrada: dict, servicio: ServicioPredicciones = Depends(obtener_servicio_predicciones)):
    prediccion = servicio.realizar_prediccion(datos_entrada)
    return {"mensaje": "Predicción realizada con éxito", "prediccion": prediccion}