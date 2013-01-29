/*
 * News.h
 *
 *  Created on: 27/gen/2013
 *      Author: Andrea
 */

#include <QString>

#ifndef NEWS_H_
#define NEWS_H_

class News {
public:
	News();
	virtual ~News();
private:
	QString date;
	QString content;
};

#endif /* NEWS_H_ */
