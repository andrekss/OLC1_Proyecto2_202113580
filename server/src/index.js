const Ejecutar = require("../Language/Parser.js");
const express = require('express');
const morgan = require('morgan');
const cors = require('cors');
const Parser = require("body-parser");

const app = express();

// Middleware para el registro de solicitudes HTTP
app.use(morgan('dev'));
this.salidaParse ="";
// Middleware para permitir solicitudes desde cualquier origen
app.use(cors());

// Middleware para analizar los cuerpos de las solicitudes entrantes
app.use(Parser.text());

app.use(express.text()); // analiza la entrada

// Ruta para manejar la petición POST
app.post('/Execute', (req, res) => {
    let Entrada = req.body;
    if (Entrada) {
      
      const consoleLog = console.log;
      
      console.log = (message) => {
        this.salidaParse += message;
      };
      Ejecutar.parse(Entrada);

      console.log = consoleLog; // restaurar 
      res.send(this.salidaParse); // Enviar la salida almacenada como respuesta      
      this.salidaParse="";
      
  }
  else {
      res.status(400).send("Vacio");
  }

    
  });

// Puerto en el que escucha el servidor
const puerto = 3000;

// Iniciar el servidor
app.listen(puerto, () => {
  console.log(`Servidor corriendo en http://localhost:${puerto}`);
});
