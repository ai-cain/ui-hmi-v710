#ifndef RADIALGRADIENTITEM_H
#define RADIALGRADIENTITEM_H

#include <QPainter>
#include <QQuickPaintedItem>

class RadialGradientItem : public QQuickPaintedItem
{
  Q_OBJECT
  Q_PROPERTY(qreal borderWidth READ borderWidth WRITE setBorderWidth NOTIFY borderWidthChanged)
  Q_PROPERTY(qreal shadowOffset READ shadowOffset WRITE setShadowOffset NOTIFY shadowOffsetChanged)
  Q_PROPERTY(qreal shadowBlur READ shadowBlur WRITE setShadowBlur NOTIFY shadowBlurChanged)

public:
  RadialGradientItem(QQuickItem *parent = nullptr);

  qreal borderWidth() const { return m_borderWidth; }
  void setBorderWidth(qreal width);

  qreal shadowOffset() const { return m_shadowOffset; }
  void setShadowOffset(qreal offset);

  qreal shadowBlur() const { return m_shadowBlur; }
  void setShadowBlur(qreal blur);

signals:
  void borderWidthChanged();
  void shadowOffsetChanged();
  void shadowBlurChanged();

protected:
  void paint(QPainter *painter) override;

private:
  qreal m_borderWidth = 0;
  qreal m_shadowOffset = 0;
  qreal m_shadowBlur = 0;
};

#endif // RADIALGRADIENTITEM_H
