const Ejecutar = require("../Language/Parser.js");

const express = require('express');
const morgan = require('morgan');
const cors = require('cors');

const app = express();

// Middleware para el registro de solicitudes HTTP
app.use(morgan('dev'));

// Middleware para permitir solicitudes desde cualquier origen
app.use(cors());

app.use(express.text()); // analiza la entrada

// Ruta para manejar la petición POST
app.post('/Execute', (req, res) => {
    // Obtener datos del cuerpo de la solicitud
    const Entrada = req.body;

    //console.log(Entrada)
    Ejecutar.parse(Entrada);
    
    //res.send(Entrada);
    
  });

// Puerto en el que escucha el servidor
const puerto = 3000;

// Iniciar el servidor
app.listen(puerto, () => {
  console.log(`Servidor corriendo en http://localhost:${puerto}`);
});
