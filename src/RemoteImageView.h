/*
 * RemoteImageView.h
 *
 *  Created on: 30/gen/2013
 *      Author: Andrea
 */

#ifndef REMOTEIMAGEVIEW_H_
#define REMOTEIMAGEVIEW_H_

#include <QObject>
#include <QString>
#include <bb/cascades/CustomControl>
#include <bb/cascades/Container>
#include <bb/cascades/ImageView>
#include <bb/cascades/Container>
#include <QTNetwork>

namespace bb {
namespace cascades {
class Container;
}
}
using namespace bb::cascades;

class RemoteImageView: public CustomControl {
Q_OBJECT
Q_PROPERTY(QString url READ URL WRITE seturl NOTIFY urlChanged)

public:
	RemoteImageView(Container *parent = 0);
	virtual ~RemoteImageView();
	Container* mRootContainer;
	ImageView* imageView;Q_INVOKABLE
	void loadImage();
	void seturl(QString url);
	QString URL();

public slots:
	void onImageLoaded(QNetworkReply* reply);
	void onurlChanged();signals:
	void imageUnavailable();
	void urlChanged(QString url);

private:
	QString murl;

};

#endif /* REMOTEIMAGEVIEW_H_ */
