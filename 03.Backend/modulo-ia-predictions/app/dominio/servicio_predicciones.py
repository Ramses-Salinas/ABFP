import pandas as pd

from app.dominio.modelo_prediccion import ModeloPrediccion

class ServicioPredicciones:
    def __init__(self, repositorio_datos):
        self.repositorio_datos = repositorio_datos

    def realizar_prediccion(self, usuario_id: int):
        # 1. Obtener datos históricos del repositorio
        datos_historicos = self.repositorio_datos.obtener_datos_usuario(usuario_id)

        # 2. Realizar la predicción
        prediccion = self._predecir(datos_historicos)

        # 3. Convertir la predicción en un formato legible
        modelo_prediccion = ModeloPrediccion(
            gastos_futuros=prediccion["gastos_futuros"],
            saldo_futuro=prediccion["saldo_futuro"],
            habitos_financieros=prediccion["habitos_financieros"],
            tendencias_gastos=prediccion["tendencias_gastos"]
        )

        return modelo_prediccion


    def _predecir(self, datos_usuario):
        # Crear un DataFrame con los datos de transacciones
        df = pd.DataFrame(datos_usuario['transacciones'])

        # Seleccionar las columnas relevantes
        df = df[['fecha', 'monto']]

        # Convertir la columna 'fecha' a formato de fecha
        df['fecha'] = pd.to_datetime(df['fecha'])

        # Ordenar el DataFrame por fecha
        df = df.sort_values('fecha')

        # Calcular la media móvil de los últimos 3 meses
        ventana = 3  # Ventana de 3 meses
        gastos_futuros = df['monto'].rolling(window=ventana).mean().iloc[-1]

        # Manejar el caso de que no haya suficientes datos para la media móvil
        if pd.isna(gastos_futuros):
            gastos_futuros = df['monto'].mean()  # Usar la media de todos los datos si no hay suficientes

        # Devolver la predicción
        return {
            "gastos_futuros": gastos_futuros,
            "saldo_futuro": 2200.00,  # Valor simulado por ahora
            "habitos_financieros": ["Gasto frecuente en alimentos", "Mayor gasto los fines de semana"],
            "tendencias_gastos": "Gastos estables"
        }