const Instruccion = require("../instruccion.js");
//const Salida = document.getElementById('Salida'); // Texto entrada

class Print extends Instruccion{

    constructor(expresion,Salto){
        super();
        this.expresion = expresion;
        this.Salto = Salto;
    }

    interpretar(entorno){
        if(this.expresion.tipo == "ERROR"){
            console.log("Error Semántico: No se puede hacer print de errores")
            return;
        }
        
        if (this.Salto=="si"){
         console.log(this.expresion.valor+"\n");
        }else{
            console.log(this.expresion.valor);
        
        }
    }

}

module.exports = Print;