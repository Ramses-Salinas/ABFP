from unittest.mock import Mock

from app.dominio.servicio_predicciones import ServicioPredicciones
from app.dominio.modelo_prediccion import ModeloPrediccion

def test_realizar_prediccion():
    # Crear un mock para el RepositorioDatos
    mock_repositorio_datos = Mock()
    mock_repositorio_datos.obtener_datos.return_value = {
        "usuario_id": 1,
        "transacciones": [],  # No necesitamos datos reales para esta prueba
        "ingresos": [],
        "saldos": []
    }

    # Crear una instancia del ServicioPredicciones con el mock
    servicio = ServicioPredicciones(mock_repositorio_datos)

    # Datos de entrada para la predicción
    datos_entrada = {"usuario_id": 1}

    # Realizar la predicción
    prediccion = servicio.realizar_prediccion(datos_entrada)

    # Verificar que la predicción es una instancia de ModeloPrediccion
    assert isinstance(prediccion, ModeloPrediccion)

    # Verificar los valores de la predicción (simulados, actualizados)
    assert prediccion.gastos_futuros == 350.00  # Actualizado
    assert prediccion.saldo_futuro == 2200.00  # Actualizado
    assert prediccion.habitos_financieros == ["Gasto frecuente en alimentos", "Mayor gasto los fines de semana"]  # Actualizado
    assert prediccion.tendencias_gastos == "Gastos estables"  # Actualizado