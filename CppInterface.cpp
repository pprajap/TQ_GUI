// CppInterface.cpp
#include "CppInterface.h"
#include <QDebug>

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

}
