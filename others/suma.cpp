#include "suma.h"

suma::suma(QObject *parent)
    : QObject{parent}, m_num1(0), m_num2(0), m_result(0)
{
    // Constructor inicializa los valores num1, num2 y result a 0.
}

int suma::num1() const
{
    // Devuelve el valor actual de num1.
    return m_num1;
}

void suma::setNum1(int newNum1)
{
    if (m_num1 != newNum1) {
        // Actualiza el valor de num1 solo si ha cambiado.
        m_num1 = newNum1;
        emit num1Changed(); // Emite señal para indicar que num1 ha cambiado.
        updateResult(); // Recalcula el resultado de la suma.
    }
}

int suma::num2() const
{
    // Devuelve el valor actual de num2.
    return m_num2;
}

void suma::setNum2(int newNum2)
{
    if (m_num2 != newNum2) {
        // Actualiza el valor de num2 solo si ha cambiado.
        m_num2 = newNum2;
        emit num2Changed(); // Emite señal para indicar que num2 ha cambiado.
        updateResult(); // Recalcula el resultado de la suma.
    }
}

int suma::result() const
{
    // Devuelve el resultado actual de la suma.
    return m_result;
}

void suma::updateResult()
{
    // Calcula la suma de num1 y num2.
    m_result = m_num1 + m_num2;
    emit resultChanged(); // Emite señal para indicar que el resultado ha cambiado.
}
