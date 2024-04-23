const Dato = require("../Expresion/Dato.js");
const Estructuras = require("./Estructura.js");

function Declarar_Linea(TipoDato, id, valor, structs){ // id(strings) y valores(cualquier dato de cualquier tipo, pero es object) son arreglos
    for (let i = 0; i < id.length; i++) {
        structs.pushVariable(id[i],Default_Values(valor[i],TipoDato),TipoDato); 
    }
    
}

function Default_Values(valor,TipoDato){ // retornar bien los datos
    if (valor == "Default"){
        switch(TipoDato.toLowerCase()){
            case "int":
                return GetDato(0, TipoDato.toUpperCase());
            case "double":
                return GetDato(0.0, TipoDato.toUpperCase());
            case "bool":
                return GetDato(true, TipoDato.toUpperCase());
            case "char":
                return GetDato('\u0000', TipoDato.toUpperCase());
            case "std::string":
                return GetDato("", TipoDato.toUpperCase());
        }

    } else{
        return valor
    }

}

function GetDato(Valor, Tipo){
    
    let dato = new Dato(Valor,Tipo); 
    return dato.interpretar();
}

var structs = new Estructuras(); // variables y vectores

module.exports = {Declarar_Linea, structs, Default_Values};