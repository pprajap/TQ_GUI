// CppInterface.cpp
#include "CppInterface.h"
#include <QDebug>
#include <qqmlengine.h>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QJsonObject>
#include <QJsonDocument>
#include <QEventLoop>

CppInterface::CppInterface(QObject *parent) : QObject(parent) {}

void CppInterface::runOptimization(int dimensions, double lowerBound, double upperBound, int gridSizeFactorP, int gridSizeFactorQ, int evals, const QString &funcName, bool isFunc, bool isVect, bool withCache, bool withLog, bool withOpt)
{
    // Implement the optimization logic here
    qDebug() << "Running optimization with parameters:";
    qDebug() << "Dimensions:" << dimensions;
    qDebug() << "Lower Bound:" << lowerBound;
    qDebug() << "Upper Bound:" << upperBound;
    qDebug() << "Grid Size Factor P:" << gridSizeFactorP;
    qDebug() << "Grid Size Factor Q:" << gridSizeFactorQ;
    qDebug() << "Number of Evals:" << evals;
    qDebug() << "Function Name:" << funcName;
    qDebug() << "is_func:" << isFunc;
    qDebug() << "is_vect:" << isVect;
    qDebug() << "with_cache:" << withCache;
    qDebug() << "with_log:" << withLog;
    qDebug() << "with_opt:" << withOpt;

    // curl -X POST http://localhost:5000/optimize -H "Content-Type: application/json" -d '{}'
    // Prepare the JSON payload
    QJsonObject json;
    json["dimensions"] = dimensions;
    json["lowerBound"] = lowerBound;
    json["upperBound"] = upperBound;
    json["gridSizeFactorP"] = gridSizeFactorP;
    json["gridSizeFactorQ"] = gridSizeFactorQ;
    json["evals"] = evals;
    json["funcName"] = funcName;
    json["isFunc"] = isFunc;
    json["isVect"] = isVect;
    json["withCache"] = withCache;
    json["withLog"] = withLog;
    json["withOpt"] = withOpt;

    QJsonDocument doc(json);
    QByteArray data = doc.toJson();

    // Setup the network request
    QNetworkAccessManager manager;
    QNetworkRequest request(QUrl("http://localhost:5000/optimize"));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

    // Send the request
    QNetworkReply *reply = manager.post(request, data);

    // Wait for the request to finish
    QEventLoop loop;
    QObject::connect(reply, &QNetworkReply::finished, &loop, &QEventLoop::quit);
    loop.exec();

    // Handle the reply
    if (reply->error() == QNetworkReply::NoError)
    {
        QByteArray response = reply->readAll();
        qDebug() << "Response:" << response;
        // Emit a signal to notify the QML side that the optimization is done
        emit optimizationDone(response);
    }
    else
    {
        qDebug() << "Error:" << reply->errorString();
        // Emit a signal to notify the QML side that an error occurred
        emit optimizationError(reply->errorString());
    }

    reply->deleteLater();
}
