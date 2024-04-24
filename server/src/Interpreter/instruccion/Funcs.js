function Operar(expIzq,operador,expDer){
    
    if(expIzq == "null" || expDer=="null"){
        console.log("Error semántico: no es posible comparar con una expresión de error");
        return;
    }
    else if(operador=="=="){
        if(expIzq.toString()==expDer.toString()){
            return true;
        }else{
            return false;
        }
    }else if(operador=="!="){
        if(expIzq.toString()!=expDer.toString()){
            return true;
        }else {
            return false;
        }
    }else if(operador=="<="){
        if(expIzq.toString() <=expDer.toString()){
            return true;
        }else{
            return false;
        }
    }else if(operador==">="){
        if(expIzq.toString() >=expDer.toString()){
            return true;
        }else{
            return false
        }
    }else if(operador=="<"){
        if(expIzq.toString() <expDer.toString()){
            return true;
        }else{
            return false
        }
    }else if(operador==">"){
        if(expIzq.toString() >expDer.toString()){
            return true;
        }else{
            return false
        }
    }else if(operador=="&&"){
        if(expIzq.toString() && expDer.toString()){
            return true;
        }else{
            return false
        }
    }else if(operador=="&&"){
        if(expIzq.toString() && expDer.toString()){
            return true;
        }else{
            return false
        }
    }else if(operador=="||"){
        if(expIzq.toString() || expDer.toString()){
            return true;
        }else{
            return false
        }
    }
    
}

module.exports = {Operar};