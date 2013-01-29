/*
 * MagPiClient.cpp
 *
 *  Created on: 27/gen/2013
 *      Author: Andrea
 */

#include "MagPiClient.h"
#include <stdio.h>
#include <QXmlStreamReader>

MagPiClient::MagPiClient() {
	m_manager = new QNetworkAccessManager(this);
}

MagPiClient::~MagPiClient() {
	// TODO Auto-generated destructor stub
}

void MagPiClient::fetchIssues() {
	connect(m_manager, SIGNAL(finished(QNetworkReply*)), this,
			SLOT(issuesPageContentFetched(QNetworkReply*)));
	m_manager->get(QNetworkRequest(QUrl("http://feeds.feedburner.com/theMagPi")));
}

void MagPiClient::fetchNews() {
	connect(m_manager, SIGNAL(finished(QNetworkReply*)), this,
			SLOT(newsPageContentFetched(QNetworkReply*)));
	m_manager->get(QNetworkRequest(QUrl("http://feeds.feedburner.com/MagPi")));
}

void MagPiClient::issuesPageContentFetched(QNetworkReply* pReply) {

	QByteArray data = pReply->readAll();
	QString str(data);

	QXmlStreamReader xml(str);

	QList<Issue>* issues = new QList<Issue>();

	Issue* issue = 0;

	while (!xml.atEnd()) {
		xml.readNext();
		if (xml.isStartElement()) {
			if (xml.name() == "item") {
				if (issue)
					issues->append(*issue);
				issue = new Issue();
			}
			if (!issue)
				continue;
			if (xml.name() == "link") {
				xml.readNext();
				issue->pdfUrl = xml.text().toString();
			}
			if (xml.name() == "title") {
				xml.readNext();
				issue->title = xml.text().toString();
			}
		} else if (xml.isEndElement()) {
		}
	}

	for (int i = 0; i < issues->size(); i++) {
		fprintf(stdout, "\n");
		fprintf(stdout, issues->at(i).title.toStdString().c_str());
	}

	emit issuesFetched(issues);

}

void MagPiClient::newsPageContentFetched(QNetworkReply* pReply) {

	QByteArray data = pReply->readAll();
	QString str(data);

	//parse

	//emit newsFetched(newsList);

}

