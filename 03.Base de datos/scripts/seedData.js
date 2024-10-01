const { MongoClient } = require('mongodb');
const express = require('express');
const app = express();

const url = 'mongodb://localhost:27017'; // Cambia esto si usas otra URL
const dbName = 'mi_base_de_datos'; // Nombre de tu base de datos
let db;

// Conectarse a MongoDB
MongoClient.connect(url, { useUnifiedTopology: true }, (err, client) => {
    if (err) throw err;
    console.log("Conectado a MongoDB");
    db = client.db(dbName);
});

// Ruta para mostrar datos en tabla HTML
app.get('/', async (req, res) => {
    const collection = db.collection('mi_coleccion'); // Nombre de tu colección
    const data = await collection.find({}).toArray(); // Extrae todos los datos

    // Genera tabla HTML con los datos
    let html = `
        <table border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Edad</th>
                    <th>Email</th>
                </tr>
            </thead>
            <tbody>
    `;

    data.forEach(item => {
        html += `
            <tr>
                <td>${item._id}</td>
                <td>${item.nombre}</td>
                <td>${item.edad}</td>
                <td>${item.email}</td>
            </tr>
        `;
    });

    html += `</tbody></table>`;
    res.send(html);
});

// Iniciar el servidor en el puerto 3000
app.listen(3000, () => {
    console.log("Servidor escuchando en http://localhost:3000");
});