const Instruccion = require("../Instruccion.js");

class Dato extends Instruccion{ // No terminal
    constructor(valor, tipo){
        super();
        this.tipo = tipo;
        this.valor = valor;
    }

    interpretar(entorno){
        switch(this.tipo){ // acomodamos los datos
            case 'Int': return Number(this.valor);
            case 'Double': return Number(this.valor);
            case 'Bool': return Boolean(this.valor);
            case 'Char': return CharacterData(this.valor);
            case 'String': return this.valor;
        }
    }

}

module.exports = Dato;