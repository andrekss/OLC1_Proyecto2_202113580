class Instruccion{ // super clase interface

    constructor(){}

    interpretar(entorno){} // Entorno = contexto
   
}

module.exports = Instruccion;

/*
// Uso de Hash maps
const variables = {};

// Agregar elementos al "variables"
variables['clave1'] = 'valor1';
variables['clave2'] = 'valor2';

// Acceder a elementos del "variables"
console.log(variables['clave1']); // Salida: valor1
console.log(variables['clave2']); // Salida: valor2

// Verificar si una clave existe en el "variables"
console.log('clave1' in variables); // Salida: true
console.log('clave3' in variables); // Salida: false

// Eliminar elementos del "variables"
delete variables['clave1'];

// Iterar sobre las claves del "variables"
for (let clave in variables) {
    console.log(clave + ': ' + variables[clave]);
}
*/