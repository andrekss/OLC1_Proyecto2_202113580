const Instruccion = require("../instruccion.js");

class Estructuras extends Instruccion {
    constructor(){
        super();
        this.Identificadores = {};
    }

    push(ID, object, tipo) {
        //console.log(this.Identificadores);
        if (tipo == "std::string".toLowerCase()){
            tipo = "string";
        }
        try {
         if (this.Identificadores.hasOwnProperty(ID)) {
             //throw new Error(`Error semántico: La variable"${ID}" ya existe.`);
             console.log("Error semántico: La variable "+ID+" ya existe.");
         } 
         
         else if(this.Identificadores[ID].tipo.toLowerCase() != tipo.toLowerCase()){
             console.log("Error semántico: El dato asignado no coincide con el tipo de dato de la variable.");
         }
         else {
             this.Identificadores[ID] = object;
         }
        } catch{
            this.Identificadores[ID] = object;
        }
    }  

    Incremento_Decremento(Id,Indicar){ // Falta la parte de vectores
       
        if(Indicar=="+" && this.Identificadores[Id].tipo.toUpperCase() =="INT"){
            this.Identificadores[Id].valor+=1;
        }else if($2=="-" && this.Identificadores[Id].tipo.toUpperCase() =="INT"){
            this.Identificadores[Id].valor-=1;
        } else {
            console.log("Error semántico: la variable no es de tipo int")
        }
    }


    interpretar(entorno){ // Retorno objeto
         return this.Identificadores[entorno.Id];
    }
}

module.exports = Estructuras;