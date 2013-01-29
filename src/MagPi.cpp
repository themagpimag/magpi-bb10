#include "MagPi.hpp"

#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include "MagPiClient.h"

using namespace bb::cascades;

MagPi::MagPi(bb::cascades::Application *app)
: QObject(app)
{
    QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);

    AbstractPane *root = qml->createRootObject<AbstractPane>();
    app->setScene(root);

}

