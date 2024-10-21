from fastapi.testclient import TestClient

from app.main import app

client = TestClient(app)

def test_predecir():
    # Datos de entrada para la predicción
    datos_entrada = {"usuario_id": 1}

    # Realizar una solicitud POST al endpoint /predicciones/predecir
    response = client.post("/predicciones/predecir", json=datos_entrada)

    # Verificar el código de estado de la respuesta
    assert response.status_code == 200

    # Verificar la estructura de la respuesta
    data = response.json()
    assert "mensaje" in data
    assert "prediccion" in data

    # Verificar los valores de la predicción (simulados, actualizados)
    prediccion = data["prediccion"]
    assert prediccion["gastos_futuros"] == 350.00  # Actualizado
    assert prediccion["saldo_futuro"] == 2200.00  # Actualizado
    assert prediccion["habitos_financieros"] == ["Gasto frecuente en alimentos", "Mayor gasto los fines de semana"]  # Actualizado
    assert prediccion["tendencias_gastos"] == "Gastos estables"  # Actualizado