/*
 * Copyright (c) 2011-2013 BlackBerry Limited.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include "applicationui.hpp"

#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/LocaleHandler>

#include <bb/data/JsonDataAccess>
#include <bb/cascades/GroupDataModel>
#include <bb/cascades/ListView>

#include <QtNetwork/QNetworkRequest>

#include <bb/cascades/Image>
#include <bb/cascades/ImageView>

#include <bb/system/InvokeManager>

#include <bb/cascades/ProgressIndicator>
#include <bb/system/SystemProgressToast>
#include <bb/system/SystemProgressDialog>
#include <bb/system/SystemToast>
#include <bb/system/SystemUiResult>

#include <bb/cascades/Label>

using namespace bb::cascades;
using namespace bb::data;
using namespace bb::system;

AbstractPane *root;

ApplicationUI::ApplicationUI(bb::cascades::Application *app) :
        		QObject(app)
{
	// prepare the localization
	m_pTranslator = new QTranslator(this);
	m_pLocaleHandler = new LocaleHandler(this);

	bool res = QObject::connect(m_pLocaleHandler, SIGNAL(systemLanguageChanged()), this, SLOT(onSystemLanguageChanged()));
	// This is only available in Debug builds
	Q_ASSERT(res);
	// Since the variable is not used in the app, this is added to avoid a
	// compiler warning
	Q_UNUSED(res);

	// initial load
	onSystemLanguageChanged();

	// Create scene document from main.qml asset, the parent is set
	// to ensure the document gets destroyed properly at shut down.
	QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);

	qml->setContextProperty("_app",this);
	// Create root object for the UI
	root = qml->createRootObject<AbstractPane>();

	// Set created root object as the application scene
	app->setScene(root);
}

void ApplicationUI::onSystemLanguageChanged()
{
	QCoreApplication::instance()->removeTranslator(m_pTranslator);
	// Initiate, load and install the application translation files.
	QString locale_string = QLocale().name();
	QString file_name = QString("themagpi_bb10_%1").arg(locale_string);
	if (m_pTranslator->load(file_name, "app/native/qm")) {
		QCoreApplication::instance()->installTranslator(m_pTranslator);
	}
}
/*
void ApplicationUI::fetchImg(QString url, ImageView *iv)
{
	m_ImageView = iv;
	QNetworkAccessManager *nam = new QNetworkAccessManager();

	QNetworkRequest req(url);

	QNetworkReply* rep = nam->get(req);

	bool ok = connect(rep, SIGNAL(finished()), this, SLOT(onFinished()));//loadData()));
	Q_ASSERT(ok);
	Q_UNUSED(ok);
}*/

void ApplicationUI::onFinished(QNetworkReply *r)
{
	//QNetworkReply *r = dynamic_cast<QNetworkReply*>(sender());

	QVariant possibleURLRedirect = r->attribute(QNetworkRequest::RedirectionTargetAttribute);

	if ( !possibleURLRedirect.toUrl().isEmpty() )
	{
		//got a redirect
		qDebug() << "redirect to " << possibleURLRedirect.toUrl();
		this->m_rep = this->m_nam->get(QNetworkRequest(possibleURLRedirect.toUrl()));
		connect(this->m_rep, SIGNAL(downloadProgress(qint64, qint64)), this, SLOT(downloadProgress(qint64, qint64)));
	}
	else
	{
		qDebug() << " ba = " << r->readAll();
		SystemToast *eod_toast = new SystemToast(this);
		SystemUiButton *toastButton = eod_toast->button();

		eod_toast->setBody("Download finished!");
		toastButton->setLabel("View PDF");
		eod_toast->show();
		connect(eod_toast, SIGNAL(finished(bb::system::SystemUiResult::Type)), this, SLOT(dwlFinished(bb::system::SystemUiResult::Type)));
	}
	r->deleteLater();
	/*
	Image img(r->readAll());// = new Image(r->readAll());

	m_ImageView->setImage(img);
	*/
}

void ApplicationUI::dwlFinished(bb::system::SystemUiResult::Type t)
{
	qDebug() << "t = " << t;
	if ( t == 5 )
	{
		qDebug() << "view downloaded pdf";
	} else {
		qDebug() << "natural expired";
	}
}

void ApplicationUI::replyFinished(QNetworkReply *r)
{
	qDebug() << " rf = " << r->readAll();
}

void ApplicationUI::downloadPDF(QString p)
{
	InvokeManager* invokeManager = new InvokeManager();
	InvokeRequest cardRequest;
	cardRequest.setTarget("sys.browser");
	cardRequest.setAction("bb.action.VIEW");
	//cardRequest.setMimeType("image/png");
	cardRequest.setUri(p);
	InvokeTargetReply* reply = invokeManager->invoke(cardRequest);
	invokeManager->setParent(this);
	//reply->setParent(this);

	/*
	progresstoast = new SystemProgressToast(this);

	progresstoast->setBody("Downloading PDF");
	    progresstoast->setProgress(1);
	    progresstoast->setStatusMessage("");
	    progresstoast->setState(SystemUiProgressState::Active);
	    progresstoast->setPosition(SystemUiPosition::MiddleCenter);
	    progresstoast->show();

	QUrl u(p);
	QNetworkRequest req;//(u);
	req.setUrl(u);
	QNetworkAccessManager *nam = new QNetworkAccessManager(this);

	connect(nam, SIGNAL(finished(QNetworkReply*)), this, SLOT(onFinished(QNetworkReply*)));


	/*
	connect(nam, SIGNAL(downloadProgress(qint64, qint64)), this, SLOT(downloadProgress(qint64, qint64)));
	connect(nam, SIGNAL(finished()), this, SLOT(onFinished()));
*/
	/*
	this->m_nam = nam;
	//this->m_req = req;


	//QNetworkReply *rep
	this->m_rep = this->m_nam->get(req);
	connect(this->m_rep, SIGNAL(downloadProgress(qint64, qint64)), this, SLOT(downloadProgress(qint64, qint64)));

	//this->m_rep = rep;
	/*this->m_nam->get(req);//this->m_req);
	connect(this->m_rep, SIGNAL(downloadProgress(qint64, qint64)), this, SLOT(downloadProgress(qint64, qint64)));
*/


	/*

	        // ... and start the download.
	        m_currentDownload = m_manager.get(request);

	        // Connect against the necessary signals to get informed about progress and status changes
	        connect(m_currentDownload, SIGNAL(downloadProgress(qint64, qint64)),
	                SLOT(downloadProgress(qint64, qint64)));
	        connect(m_currentDownload, SIGNAL(finished()), SLOT(downloadFinished()));
	        connect(m_currentDownload, SIGNAL(readyRead()), SLOT(downloadReadyRead()));
	        */

}

void ApplicationUI::setPID(bb::cascades::ProgressIndicator *pid)
{

	m_pid = pid;
	m_pid->setFromValue(0);

}

void ApplicationUI::downloadProgress(qint64 br, qint64 bt)
{
	pt = bt;
	pv = br;
	qDebug() << "loaded at " << QString::number(pt) << " and = " << QString::number(pv);

	float percentage = (100 * pv ) / pt;
	qDebug() << "percentage = " << QString::number(percentage);

	/*
	 * label = zonesInstance->findChild<bb::cascades::Label*>("sLb");
QString labelText = "Test Change";

qDebug() << label->text();
label->setText(labelText);
	 */

	m_prolbl->setText(QString::number(percentage) + " %");

	/*
	bb::cascades::Label *lbl = root->findChild<bb::cascades::Label*>("dwlProgress");
	if ( lbl )
		lbl->setText(QString::number(percentage) + " %");
	else qDebug() << "label not valid";
*/
	/*
	QObject *dlabel = root->findChild<QObject*>("dwlProgress");
	if (dlabel)
		dlabel->setProperty("text", QString::number(percentage) + " %");
*/
//	root->findChild("dwlProgress");
/*
	progresstoast->setProgress(percentage);

	m_pid->setToValue(pt/1000);
	m_pid->setValue(pv/1000);
	*/

}

void ApplicationUI::setProgressLabel(bb::cascades::Label *aLabel)
{
	m_prolbl = aLabel;
}
/*
void ApplicationUI::viewPDF(QString r)
{
	InvokeManager* invokeManager = new InvokeManager();
	InvokeRequest cardRequest;
	cardRequest.setTarget("com.rim.bb.app.adobeReader.viewer");
	cardRequest.setAction("bb.action.VIEW");
	cardRequest.setMimeType("application/pdf");
	cardRequest.setUri(r);
	InvokeTargetReply* reply = invokeManager->invoke(cardRequest);
	invokeManager->setParent(this);
}
*/
