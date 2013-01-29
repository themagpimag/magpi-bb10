#ifndef MagPi_HPP_
#define MagPi_HPP_

#include <QObject>
#include <bb/cascades/AbstractPane>
#include "MagPiClient.h"

namespace bb {namespace cascades {class Application;}}

class MagPi: public QObject {
Q_OBJECT
public:
	MagPi(bb::cascades::Application *app);
	virtual ~MagPi() {
	}
private:
	bb::cascades::AbstractPane* root;
	MagPiClient* magpi_client;
	void onStart();
private slots:
	void onIssuesFetched(QList<Issue>* issues);
};

#endif /* MagPi_HPP_ */
