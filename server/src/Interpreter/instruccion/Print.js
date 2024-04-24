const Instruccion = require("../instruccion.js");

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
         console.log(this.expresion.valor);
        }else{
            process.stdout.write(this.expresion.valor.toString());
        }
    }

}

module.exports = Print;