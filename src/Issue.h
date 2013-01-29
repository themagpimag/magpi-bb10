/*
 * Issue.h
 *
 *  Created on: 27/gen/2013
 *      Author: Andrea
 */

#include <QString>

#ifndef ISSUE_H_
#define ISSUE_H_

class Issue {
public:
	Issue();
	virtual ~Issue();
private:
	QString date;
	QString title;
	QString pdfUrl;
	QString imgUrl;
};

#endif /* ISSUE_H_ */
