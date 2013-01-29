/*
 * MagPiClient.h
 *
 *  Created on: 27/gen/2013
 *      Author: Andrea
 */

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QString>
#include "Issue.h"
#include <QList>

#ifndef MAGPICLIENT_H_
#define MAGPICLIENT_H_

class MagPiClient : public QObject {
	Q_OBJECT
public:
	MagPiClient();
	void fetchIssues();
	void fetchNews();
	virtual ~MagPiClient();
signals:
	void issuesFetched(QList<Issue>* issues);
	void newsFetched(QList<Issue>* issues);
private slots:
	void issuesPageContentFetched(QNetworkReply* pReply);
	void newsPageContentFetched(QNetworkReply* pReply);

private:
	QNetworkAccessManager* m_manager;
};

#endif /* MAGPICLIENT_H_ */
