// CppInterface.h
#ifndef CPPINTERFACE_H
#define CPPINTERFACE_H

#include <QObject>

class CppInterface : public QObject
{
    Q_OBJECT
public:
    explicit CppInterface(QObject *parent = nullptr);

public slots:
    void runOptimization(int dimensions, double lowerBound, double upperBound, int gridSizeFactorP, int gridSizeFactorQ, int evals, const QString &funcName, bool isFunc, bool isVect, bool withCache, bool withLog, bool withOpt);
};

#endif // CPPINTERFACE_H