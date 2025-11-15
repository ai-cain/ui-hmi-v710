#include "operacion.h"

Operacion::Operacion(QObject *parent)
    : QObject(parent)
    , m_num1(0)
    , m_num2(0)
    , m_suma(0)
    , m_resta(0)
    , m_multiplicacion(0)
    , m_division(0.0)
    , m_potencia1(0)
    , m_potencia2(0)
{
  // Constructor inicializa los valores a 0 o a valores predeterminados.
  connect(this, &Operacion::num1Changed, this, &Operacion::onNum1Changed);
  connect(this, &Operacion::num2Changed, this, &Operacion::onNum2Changed);
}

int Operacion::num1() const
{
  return m_num1;
}
void Operacion::setNum1(int newNum1)
{
  if (m_num1 != newNum1) {
    m_num1 = newNum1;
    emit num1Changed(); // Emitir señal de cambio de num1
  }
}

int Operacion::num2() const
{
  return m_num2;
}
void Operacion::setNum2(int newNum2)
{
  if (m_num2 != newNum2) {
    m_num2 = newNum2;
    emit num2Changed(); // Emitir señal de cambio de num2
  }
}

int Operacion::suma() const
{
  return m_suma;
}
int Operacion::resta() const
{
  return m_resta;
}
int Operacion::multiplicacion() const
{
  return m_multiplicacion;
}
double Operacion::division() const
{
  return m_division;
}
int Operacion::potencia1() const
{
  return m_potencia1;
}
int Operacion::potencia2() const
{
  return m_potencia2;
}

void Operacion::updateResults()
{
  m_suma = m_num1 + m_num2;
  emit sumaChanged();

  m_resta = m_num1 - m_num2;
  emit restaChanged();

  m_multiplicacion = m_num1 * m_num2;
  emit multiplicacionChanged();

  if (m_num2 != 0) {
    m_division = static_cast<double>(m_num1) / m_num2;
  } else {
    m_division = std::numeric_limits<double>::infinity(); // Manejar división por cero
  }
  emit divisionChanged();

  m_potencia1 = static_cast<int>(std::pow(m_num1, m_num2));
  emit potencia1Changed();

  m_potencia2 = static_cast<int>(std::pow(m_num2, m_num1));
  emit potencia2Changed();
}

void Operacion::onNum1Changed()
{
  updateResults();
}

void Operacion::onNum2Changed()
{
  updateResults();
}
