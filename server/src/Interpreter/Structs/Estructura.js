const Instruccion = require("../instruccion.js");

class Estructuras extends Instruccion {
    constructor(){
        this.Variables = []
        this.Vectores= []
    }

    pushVariable(Variable) { 
        this.Variables.push(Variable);
    }

    interpretar(entorno){ // Retorno

    }
}