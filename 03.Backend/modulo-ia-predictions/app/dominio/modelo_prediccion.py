from pydantic import BaseModel

class ModeloPrediccion(BaseModel):
    gastos_futuros: float
    saldo_futuro: float
    habitos_financieros: list[str]
    tendencias_gastos: str