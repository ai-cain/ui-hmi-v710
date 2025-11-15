
// Crea un objeto para almacenar los valores y el resultado
var sumaObject = {
    num1: 2,
    num2: 5,
    result: 0
};

// Actualiza el valor de num1 y recalcula el resultado
function updateNum1(newNum1) {
    sumaObject.num1 = newNum1;
    updateResult();
}

// Actualiza el valor de num2 y recalcula el resultado
function updateNum2(newNum2) {
    sumaObject.num2 = newNum2;
    updateResult();
}

// Recalcula el resultado de la suma
function updateResult() {
    sumaObject.result = sumaObject.num1 + sumaObject.num2;
}

// Obtiene el resultado actual de la suma
function getResult() {
    return sumaObject.result;
}

// Resetea los valores de num1 y num2
function resetValues() {
    sumaObject.num1 = 0;
    sumaObject.num2 = 0;
    updateResult();
}
