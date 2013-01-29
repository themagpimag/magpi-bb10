/*
 * MagPiClient.h
 *
 *  Created on: 27/gen/2013
 *      Author: Andrea
 */

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>

#ifndef MAGPICLIENT_H_
#define MAGPICLIENT_H_

class MagPiClient : public QObject {
	Q_OBJECT
public:
	MagPiClient();
	void fetchIssues();
	void fetchNews();
	virtual ~MagPiClient();
public slots:
	void issuesFetched(QNetworkReply* pReply);
	void newsFetched(QNetworkReply* pReply);

private:
	QNetworkAccessManager* m_manager;
};

#endif /* MAGPICLIENT_H_ */
