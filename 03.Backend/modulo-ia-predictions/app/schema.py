import strawberry
from typing import List

from app.dominio.modelo_prediccion import ModeloPrediccion
from app.dominio.servicio_predicciones import ServicioPredicciones
from app.infraestructura.repositorios.repositorio_datos import RepositorioDatos

@strawberry.type
class Prediccion:
    """Representa una predicción financiera."""
    gastos_futuros: float
    saldo_futuro: float
    habitos_financieros: List[str]
    tendencias_gastos: str

@strawberry.type
class Query:
    @strawberry.field
    def prediccion(self, usuario_id: int) -> Prediccion:
        """Obtiene una predicción financiera para un usuario."""
        
        # Crear una instancia del repositorio para el usuario_id
        repositorio = RepositorioDatos(usuario_id=usuario_id)  

        # Obtener la predicción del servicio
        servicio = ServicioPredicciones(repositorio_datos=repositorio)
        modelo_prediccion = servicio.realizar_prediccion(usuario_id)

        return Prediccion(
            gastos_futuros=modelo_prediccion.gastos_futuros,
            saldo_futuro=modelo_prediccion.saldo_futuro,
            habitos_financieros=modelo_prediccion.habitos_financieros,
            tendencias_gastos=modelo_prediccion.tendencias_gastos,
        )

schema = strawberry.Schema(query=Query)
