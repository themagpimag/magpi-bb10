// Default empty project template
#ifndef MagPi_HPP_
#define MagPi_HPP_

#include <QObject>

namespace bb { namespace cascades { class Application; }}

/*!
 * @brief Application pane object
 *
 *Use this object to create and init app UI, to create context objects, to register the new meta types etc.
 */
class MagPi : public QObject
{
    Q_OBJECT
public:
    MagPi(bb::cascades::Application *app);
    virtual ~MagPi() {}
};


#endif /* MagPi_HPP_ */
