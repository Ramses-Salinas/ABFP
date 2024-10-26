from unittest.mock import Mock

from app.dominio.servicio_predicciones import ServicioPredicciones
from app.dominio.modelo_prediccion import ModeloPrediccion

def test_realizar_prediccion():
    # Crear un mock para el RepositorioDatos
    mock_repositorio_datos = Mock()
    # Asegúrate de que mock_repositorio_datos.obtener_datos.return_value 
    # devuelva datos con la estructura correcta, incluyendo "transacciones"
    mock_repositorio_datos.obtener_datos.return_value = {
        "usuario_id": 1,
        "transacciones": [
            {"fecha": "2023-01-05", "descripcion": "Supermercado", "categoria": "Alimentos", "monto": 120.50},
            {"fecha": "2023-01-10", "descripcion": "Restaurante", "categoria": "Restaurantes", "monto": 55.00}
            # ... más datos de ejemplo si es necesario
        ],
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

    # Verificar el tipo de dato y el valor de gastos_futuros (actualizado)
    assert isinstance(prediccion.gastos_futuros, (float, int))
    assert prediccion.gastos_futuros >= 0  # Mayor o igual que cero