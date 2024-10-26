from fastapi import FastAPI
import strawberry
from strawberry.fastapi import GraphQLRouter

from app.schema import schema  # Asegúrate de que la ruta sea correcta

app = FastAPI()

graphql_app = GraphQLRouter(schema)
app.include_router(graphql_app, prefix="/graphql")

@app.get("/")
async def root():
    return {"message": "Hola desde FastAPI"}