#ifndef SUMA_H
#define SUMA_H

#include <QObject>

/**
 * @brief La clase suma realiza la suma de dos números enteros y notifica los cambios.
 *
 * Esta clase expone tres propiedades a través del sistema de propiedades de Qt:
 * - num1: El primer número en la suma.
 * - num2: El segundo número en la suma.
 * - result: El resultado de sumar num1 y num2.
 */
class suma : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int num1 READ num1 WRITE setNum1 NOTIFY num1Changed)
    Q_PROPERTY(int num2 READ num2 WRITE setNum2 NOTIFY num2Changed)
    Q_PROPERTY(int result READ result NOTIFY resultChanged)

public:
    explicit suma(QObject *parent = nullptr);

    /**
     * @brief Obtiene el valor actual de num1.
     * @return El valor de num1.
     */
    int num1() const;

    /**
     * @brief Establece un nuevo valor para num1.
     * @param newNum1 El nuevo valor para num1.
     */
    void setNum1(int newNum1);

    /**
     * @brief Obtiene el valor actual de num2.
     * @return El valor de num2.
     */
    int num2() const;

    /**
     * @brief Establece un nuevo valor para num2.
     * @param newNum2 El nuevo valor para num2.
     */
    void setNum2(int newNum2);

    /**
     * @brief Obtiene el resultado de la suma de num1 y num2.
     * @return El resultado de la suma.
     */
    int result() const;

signals:
    /**
     * @brief Señal emitida cuando num1 cambia.
     */
    void num1Changed();

    /**
     * @brief Señal emitida cuando num2 cambia.
     */
    void num2Changed();

    /**
     * @brief Señal emitida cuando el resultado cambia.
     */
    void resultChanged();

private:
    /**
     * @brief Actualiza el resultado de la suma y emite la señal correspondiente.
     */
    void updateResult();

    int m_num1; /**< Valor del primer número en la suma. */
    int m_num2; /**< Valor del segundo número en la suma. */
    int m_result; /**< Resultado de la suma de num1 y num2. */
};

#endif // SUMA_H
