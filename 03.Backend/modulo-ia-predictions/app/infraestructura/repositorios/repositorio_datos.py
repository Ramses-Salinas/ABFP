import json

class RepositorioDatos:
    def __init__(self):
        # Cargar los datos de prueba desde el archivo JSON
        with open("datos_prueba.json", "r") as f:
            self.datos = json.load(f)

    def obtener_datos(self, usuario_id):
        # Filtrar los datos por usuario_id
        # En este caso, solo tenemos datos para un usuario
        if self.datos["usuario_id"] == usuario_id:
            return self.datos
        else:
            return None