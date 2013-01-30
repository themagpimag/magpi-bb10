/*
 * RemoteImageView.cpp
 *
 *  Created on: 30/gen/2013
 *      Author: Andrea
 */

#include "RemoteImageView.h"
#include <bb/cascades/Container>
#include <bb/cascades/ImageView>
#include <bb/cascades/ScalingMethod>
#include <bb/cascades/DockLayout>

using namespace bb::cascades;

RemoteImageView::RemoteImageView(Container *parent) :
        CustomControl(parent) {
	//Q_UNUSED(parent);
	mRootContainer = new Container();
	mRootContainer->setLayout(new DockLayout);
	imageView = ImageView::create().image(
			QUrl("asset:///images/defaultarticlelist.png")).horizontal(
			HorizontalAlignment::Center).vertical(VerticalAlignment::Center);
	imageView->setScalingMethod(bb::cascades::ScalingMethod::AspectFit);
	mRootContainer->add(imageView);
	setRoot(mRootContainer);
	connect(this, SIGNAL(urlChanged(QString)), this, SLOT(onurlChanged()));
	//  connect(mRootContainer->layout(), SIGNAL(CreationCompleted()), this, SLOT(onurlChanged()));

}

RemoteImageView::~RemoteImageView() {
	//delete mRootContainer;
}

void RemoteImageView::loadImage() {
	qDebug() << murl;
	QNetworkRequest request = QNetworkRequest();
	request.setUrl(QUrl(murl));
	QNetworkAccessManager* nam = new QNetworkAccessManager(this);
	bool result = connect(nam, SIGNAL(finished(QNetworkReply*)), this,
			SLOT(onImageLoaded(QNetworkReply*)));
	Q_ASSERT(result);
	Q_UNUSED(result);

	nam->get(request);
}
void RemoteImageView::onurlChanged() {
	loadImage();

}
void RemoteImageView::onImageLoaded(QNetworkReply* reply) {
	if (reply->error() != QNetworkReply::NoError) {
		emit imageUnavailable();
		return;
	}
	Image image = Image(reply->readAll());
	imageView->setImage(image);

}
void RemoteImageView::seturl(QString url) {
	if (murl.compare(url) != 0) {
		murl = url;
		emit urlChanged(murl);
	}
}
QString RemoteImageView::URL() {
	return murl;
}

