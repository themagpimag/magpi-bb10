/*
 * MagPiClient.cpp
 *
 *  Created on: 27/gen/2013
 *      Author: Andrea
 */

#include "MagPiClient.h"
#include <stdio.h>

MagPiClient::MagPiClient() {
	m_manager = new QNetworkAccessManager(this);

}

MagPiClient::~MagPiClient() {
	// TODO Auto-generated destructor stub
}

void MagPiClient::fetchIssues() {
	connect(m_manager, SIGNAL(finished(QNetworkReply*)),
		 this, SLOT(issuesFetched(QNetworkReply*)));
	m_manager->get(QNetworkRequest(QUrl("http://feeds.feedburner.com/theMagPi")));
}

void MagPiClient::fetchNews() {
	connect(m_manager, SIGNAL(finished(QNetworkReply*)),
		 this, SLOT(issuesFetched(QNetworkReply*)));
	m_manager->get(QNetworkRequest(QUrl("http://feeds.feedburner.com/MagPi")));
}

void MagPiClient::issuesFetched(QNetworkReply* pReply) {

    QByteArray data = pReply->readAll();
    QString str(data);

    fprintf(stdout, str.toStdString().c_str());

    //parse

}

void MagPiClient::newsFetched(QNetworkReply* pReply) {

    QByteArray data = pReply->readAll();
    QString str(data);

    fprintf(stdout, str.toStdString().c_str());

}

