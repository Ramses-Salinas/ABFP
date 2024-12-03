import json

class RepositorioDatos:
    def __init__(self, usuario_id: int):
        self.usuario_id = usuario_id
        self.ruta_archivo_datos = f"datos_usuario_{usuario_id}.json"  # Construir la ruta del archivo
        self._cargar_datos()

    def _cargar_datos(self):
        try:
            with open(self.ruta_archivo_datos, "r") as f:
                self.datos = json.load(f)
                # Filtrar los datos para el usuario_id especificado
                self.usuario = next((usuario for usuario in self.datos["usuarios"] if usuario["usuario_id"] == self.usuario_id), None)
        except FileNotFoundError:
            print(f"Error: No se encontró el archivo {self.ruta_archivo_datos}")
            self.usuario = None

    def obtener_datos_usuario(self, usuario_id: int = None):  # usuario_id ya no es necesario aquí
        return self.usuario