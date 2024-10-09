// import QtQuick

// Window {
//     width: 800
//     height: 600
//     visible: true
//     title: qsTr("TQ_GUI")
// }

import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 800
    height: 800
    title: "Function Optimization Input"

    Column {
        spacing: 10
        anchors.left: parent.left
        anchors.leftMargin: 100

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
            model: ["Simple", "Tensor", "Alpine"]
            currentIndex: 1 // Default to "Tensor"
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
}
