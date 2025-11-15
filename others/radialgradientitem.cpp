#include "radialgradientitem.h"
#include <QBrush>
#include <QPainterPath>
#include <QPen>

RadialGradientItem::RadialGradientItem(QQuickItem *parent)
    : QQuickPaintedItem(parent)
{
  // Configuración inicial, si es necesaria
}

void RadialGradientItem::setBorderWidth(qreal width)
{
  if (m_borderWidth != width) {
    m_borderWidth = width;
    emit borderWidthChanged();
    update();
  }
}

void RadialGradientItem::setShadowOffset(qreal offset)
{
  if (m_shadowOffset != offset) {
    m_shadowOffset = offset;
    emit shadowOffsetChanged();
    update();
  }
}

void RadialGradientItem::setShadowBlur(qreal blur)
{
  if (m_shadowBlur != blur) {
    m_shadowBlur = blur;
    emit shadowBlurChanged();
    update();
  }
}

void RadialGradientItem::paint(QPainter *painter)
{
  QPainterPath path;
  qreal halfBorder = m_borderWidth / 2;

  // Crear un path para el borde
  path.addRect(halfBorder, halfBorder, width() - m_borderWidth, height() - m_borderWidth);

  // Configurar el color de la sombra
  QLinearGradient shadowGradient(-m_shadowOffset,
				 -m_shadowOffset,
				 width() + m_shadowOffset,
				 height() + m_shadowOffset);
  shadowGradient.setColorAt(0.0, Qt::black);
  shadowGradient.setColorAt(1.0, Qt::transparent);

  QPen shadowPen(shadowGradient);
  shadowPen.setWidthF(m_borderWidth);
  shadowPen.setJoinStyle(Qt::RoundJoin);
  shadowPen.setCapStyle(Qt::RoundCap);

  painter->setRenderHint(QPainter::Antialiasing, true);
  painter->setPen(shadowPen);
  painter->drawPath(path);
}
