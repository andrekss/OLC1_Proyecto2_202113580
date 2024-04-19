const Instruccion = require("../instruccion.js");

class Dato extends Instruccion{ // No terminal
    constructor(valor, tipo){
        super();
        this.tipo = tipo;
        this.valor = valor;
    }

    interpretar(entorno){
        switch(this.tipo){ // acomodamos los datos
            case 'INT': return Number(this.valor);
            case 'DOUBLE': return Number(this.valor);
            case 'BOOL': return Boolean(this.valor);
            case 'CHAR': return CharacterData(this.valor);
            case 'STRING': return this.valor;
        }
    }

}

module.exports = Dato;