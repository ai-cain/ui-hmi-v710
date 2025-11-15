#ifndef OPERACION_H
#define OPERACION_H

#include <QObject>
#include <cmath>  // Para pow() en cálculos de potencia
#include <limits> // Para std::numeric_limits

/**
 * @brief La clase Operacion realiza varias operaciones matemáticas entre dos números enteros y notifica los cambios.
 *
 * Esta clase expone varias propiedades a través del sistema de propiedades de Qt:
 * - num1: El primer número en las operaciones.
 * - num2: El segundo número en las operaciones.
 * - suma: El resultado de sumar num1 y num2.
 * - resta: El resultado de restar num2 de num1.
 * - multiplicacion: El resultado de multiplicar num1 y num2.
 * - division: El resultado de dividir num1 entre num2, si num2 no es cero.
 * - potencia1: El resultado de elevar num1 a la potencia num2.
 * - potencia2: El resultado de elevar num2 a la potencia num1.
 */
class Operacion : public QObject
{
  Q_OBJECT
  Q_PROPERTY(int num1 READ num1 WRITE setNum1 NOTIFY num1Changed)
  Q_PROPERTY(int num2 READ num2 WRITE setNum2 NOTIFY num2Changed)
  Q_PROPERTY(int suma READ suma NOTIFY sumaChanged)
  Q_PROPERTY(int resta READ resta NOTIFY restaChanged)
  Q_PROPERTY(int multiplicacion READ multiplicacion NOTIFY multiplicacionChanged)
  Q_PROPERTY(double division READ division NOTIFY divisionChanged)
  Q_PROPERTY(int potencia1 READ potencia1 NOTIFY potencia1Changed)
  Q_PROPERTY(int potencia2 READ potencia2 NOTIFY potencia2Changed)

public:
  explicit Operacion(QObject *parent = nullptr);

  int num1() const;
  void setNum1(int newNum1);

  int num2() const;
  void setNum2(int newNum2);

  int suma() const;
  int resta() const;
  int multiplicacion() const;
  double division() const;
  int potencia1() const;
  int potencia2() const;

signals:
  void num1Changed();
  void num2Changed();
  void sumaChanged();
  void restaChanged();
  void multiplicacionChanged();
  void divisionChanged();
  void potencia1Changed();
  void potencia2Changed();

private slots:
  void onNum1Changed();
  void onNum2Changed();

private:
  void updateResults();

  int m_num1;
  int m_num2;
  int m_suma;
  int m_resta;
  int m_multiplicacion;
  double m_division;
  int m_potencia1;
  int m_potencia2;
};

#endif // OPERACION_H
