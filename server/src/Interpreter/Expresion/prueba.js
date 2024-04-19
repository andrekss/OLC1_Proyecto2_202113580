const Dato = require("./Dato"); // Importación
const Aritmetica = require("./Aritmetica");

// Suponiendo que 'entorno' es un objeto con la información necesaria para la interpretación

// Crear una instancia de Dato
const dato = new Dato("10", "INT");
let Operar = new Aritmetica()

// Interpretar el dato en el entorno definido
const resultado = dato.interpretar(entorno);

console.log(resultado);
