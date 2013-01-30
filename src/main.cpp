#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>

#include <QLocale>
#include <QTranslator>
#include <Qt/qdeclarativedebug.h>
#include "MagPi.hpp"
#include "RemoteImageView.h"

using namespace bb::cascades;

Q_DECL_EXPORT int main(int argc, char **argv)
{
    Application app(argc, argv);

    QTranslator translator;
    QString locale_string = QLocale().name();
    QString filename = QString( "MagPi_%1" ).arg( locale_string );
    if (translator.load(filename, "app/native/qm")) {
        app.installTranslator( &translator );
    }

    qmlRegisterType<RemoteImageView>("my.library", 1, 0, "RemoteImageView");

    new MagPi(&app);

    return Application::exec();
}
