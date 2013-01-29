#include "MagPi.hpp"

#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/ListView>
#include <bb/data/DataSource>
#include <bb/cascades/QListDataModel>
#include <QList>
#include <QString>

using namespace bb::cascades;

MagPi::MagPi(bb::cascades::Application *app) :
		QObject(app) {
	bb::data::DataSource::registerQmlTypes();

	QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);

	root = qml->createRootObject<AbstractPane>();
	app->setScene(root);

	magpi_client = new MagPiClient();
	connect(magpi_client, SIGNAL(issuesFetched(QList<Issue>*)), this,
			SLOT(onIssuesFetched(QList<Issue>*)));
	magpi_client->fetchIssues();

}

void MagPi::onIssuesFetched(QList<Issue> *issues) {

	ListView *listView = root->findChild<ListView*>("issuesListView");
	QList<QString> list = QList<QString>();

	for (int i = 0; i < issues->size(); i++)
		list << issues->at(i).title;

	listView->setDataModel(new QListDataModel<QString>(list));

}

