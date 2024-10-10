import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 900
    height: 900
    title: "Function Optimization Input"

    Row {
        spacing: 50
        anchors.margins: 50

        Column {
            spacing: 10

            // Dimension Input (d)
            Label { text: "Dimensions (d):" }
            Slider {
                id: dimensionsInput
                from: 1
                to: 100
                value: 10
                stepSize: 1
                onValueChanged: dimensionsLabel.text = value.toString()
            }
            Label {
                id: dimensionsLabel
                text: dimensionsInput.value.toString()
            }

            // Grid Lower Bound (a)
            Label { text: "Grid Lower Bound (a):" }
            Slider {
                id: lowerBoundInput
                from: -10.0
                to: 10.0
                value: -1.0
                stepSize: 0.1
                onValueChanged: lowerBoundLabel.text = value.toString()
            }
            Label {
                id: lowerBoundLabel
                text: lowerBoundInput.value.toString()
            }

            // Grid Upper Bound (b)
            Label { text: "Grid Upper Bound (b):" }
            Slider {
                id: upperBoundInput
                from: -10.0
                to: 10.0
                value: 1.0
                stepSize: 0.1
                onValueChanged: upperBoundLabel.text = value.toString()
            }
            Label {
                id: upperBoundLabel
                text: upperBoundInput.value.toString()
            }

            // Grid Size Factor (p)
            Label { text: "Grid Size Factor (p):" }
            Slider {
                id: gridSizeFactorInputP
                from: 1
                to: 20
                value: 4
                stepSize: 1
                onValueChanged: gridSizeFactorLabelP.text = value.toString()
            }
            Label {
                id: gridSizeFactorLabelP
                text: gridSizeFactorInputP.value.toString()
            }

            // Grid Size Factor (q)
            Label { text: "Grid Size Factor (q):" }
            Slider {
                id: gridSizeFactorInputQ
                from: 1
                to: 20
                value: 4
                stepSize: 1
                onValueChanged: gridSizeFactorLabelQ.text = value.toString()
            }
            Label {
                id: gridSizeFactorLabelQ
                text: gridSizeFactorInputQ.value.toString()
            }

            // Number of Requests to Function (evals)
            Label { text: "Number of Evals:" }
            SpinBox {
                id: evalsInput
                from: 1
                to: 100000
                value: 100000
            }

            // Display name for func
            Label { text: "Display name for function:" }
            ComboBox {
                id: dispFuncName
                model: ["Simple", "Tensor", "Alpine", "Rosenbrock", "Rastrigin", "Sphere", "Styblinski-Tang"]
                currentIndex: 0 // Default to "Simple"
                function onCurrentIndexChanged() {
                    functionInfo.text = "Function Info: " + parent.getFunctionInfo(dispFuncName.currentText)
                }
            }

            function getFunctionInfo(functionName) {
                switch (functionName) {
                    case "Alpine":
                        return "f(x) = sum(abs(x * sin(x) + 0.1 * x)), x in [-10, 10]";
                    case "Simple":
                        return "f(x) = sin(0.1 * x[0])**2 + 0.1 * sum(x[1:]**2), x in [-1, 1]";
                    case "Tensor":
                        return "f(i) = (i[0] - 2)**2 + (i[1] - 3)**2 + sum(i[2:]**4), i in [0, 1, 2, 3]";
                    case "Rosenbrock":
                        return "f(x) = sum(100 * (x[i+1] - x[i]**2)**2 + (1 - x[i])**2), x in [-2.048, 2.048]";
                    case "Rastrigin":
                        return "f(x) = 10 * d + sum(x[i]**2 - 10 * cos(2 * pi * x[i])), x in [-5.12, 5.12]";
                    case "Sphere":
                        return "f(x) = sum(x**2), x in [-5.12, 5.12]";
                    case "Styblinski-Tang":
                        return "f(x) = 0.5 * sum(x**4 - 16 * x**2 + 5 * x), x in [-5, 5]";
                    default:
                        return "No information available.";
                }
            }

            Label {
                id: functionInfo
                text: "Function Info: " + parent.getFunctionInfo(dispFuncName.currentText)
                wrapMode: TextEdit.Wrap
                width: 300
                height: 100
            }

            // Flags and Options
            CheckBox { id: isFuncCheck; text: "is_func"; checked: true }
            CheckBox { id: isVectCheck; text: "is_vect"; checked: true }
            CheckBox { id: withCacheCheck; text: "with_cache"; checked: false }
            CheckBox { id: withLogCheck; text: "with_log"; checked: true }
            CheckBox { id: withOptCheck; text: "with_opt"; checked: false }

            // Submit Button
            Button {
                text: "Run Optimization"
                onClicked: {
                    // Send data to the C++ backend for processing
                    cppInterface.runOptimization(
                        dimensionsInput.value,
                        lowerBoundInput.value,
                        upperBoundInput.value,
                        gridSizeFactorInputP.value,
                        gridSizeFactorInputQ.value,
                        evalsInput.value,
                        dispFuncName.currentText,
                        isFuncCheck.checked,
                        isVectCheck.checked,
                        withCacheCheck.checked,
                        withLogCheck.checked,
                        withOptCheck.checked
                    )
                }
            }
        }

        Column {
            spacing: 10

            // Solver Output
            Label { text: "Solver Output:" }

            // Convergence Status
            Label { text: "Convergence Status:" }
            TextArea {
                id: convergenceStatus
                readOnly: true
                width: 200
                height: 50
                wrapMode: TextEdit.Wrap
            }

            // Solution
            Label { text: "Solution:" }
            TextArea {
                id: solutionOutput
                readOnly: true
                width: 200
                height: 50
                wrapMode: TextEdit.Wrap
            }

            // Minima Value
            Label { text: "Minima Value:" }
            TextArea {
                id: minimaValue
                readOnly: true
                width: 200
                height: 50
                wrapMode: TextEdit.Wrap
            }

            // Download Button
            Button {
                text: "Download Solution"
                onClicked: {
                    cppInterface.downloadSolution()
                }
            }
        }
        Connections {
            target: cppInterface
            function onOptimizationDone(convergenceStatusMessage, solution, minima) {
                convergenceStatus.text = "Convergence Status: " + convergenceStatusMessage
                solutionOutput.text = "Solution: " + solution
                minimaValue.text = "Minima Value: " + minima
            }
            function onOptimizationError(errorMessage) {
                convergenceStatus.text = "Error: " + errorMessage
            }
        }
    }
}
