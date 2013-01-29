#ifndef MagPi_HPP_
#define MagPi_HPP_

#include <QObject>

namespace bb { namespace cascades { class Application; }}

class MagPi : public QObject
{
    Q_OBJECT
public:
    MagPi(bb::cascades::Application *app);
    virtual ~MagPi() {}
};


#endif /* MagPi_HPP_ */
