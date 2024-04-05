from PyQt6 import QtCore, QtGui, QtWidgets

class Ui_Form(object):
    def setupUi(self, Form):
        Form.setObjectName("Form")
        Form.resize(800, 600)

        # Цвета
        background_color = "lightgray"
        text_color = "black"
        button_color = "gray"
        groupBox_color = "darkgray"

        # Применение стилей к виджетам
        Form.setStyleSheet(f"background-color: {background_color};")
        layout = QtWidgets.QVBoxLayout(Form)

        self.label = QtWidgets.QLabel(Form)
        self.label.setObjectName("label")
        self.label.setStyleSheet(f"color: {text_color};")
        self.label.setAlignment(QtCore.Qt.AlignmentFlag.AlignCenter)
        self.label.setFont(QtGui.QFont("Arial", 18, QtGui.QFont.Weight.Bold))
        layout.addWidget(self.label)

        self.comboBox = QtWidgets.QComboBox(Form)
        self.comboBox.setObjectName("comboBox")
        self.comboBox.setGeometry(QtCore.QRect(20, 50, 200, 25))  # Изменение расположения
        self.comboBox.setStyleSheet("background-color: lightblue;")
        layout.addWidget(self.comboBox)

        self.groupBox = QtWidgets.QGroupBox(Form)
        self.groupBox.setObjectName("groupBox")
        self.groupBox.setStyleSheet(f"background-color: {groupBox_color};")
        layout.addWidget(self.groupBox)

        self.groupBox_2 = QtWidgets.QGroupBox(Form)
        self.groupBox_2.setObjectName("groupBox_2")
        self.groupBox_2.setStyleSheet(f"background-color: {groupBox_color};")
        layout.addWidget(self.groupBox_2)

        self.pushButton = QtWidgets.QPushButton(Form)
        self.pushButton.setObjectName("pushButton")
        self.pushButton.setGeometry(QtCore.QRect(600, 20, 150, 30))  # Изменение расположения
        self.pushButton.setStyleSheet(f"background-color: {button_color}; color: {text_color};")
        layout.addWidget(self.pushButton)

        self.retranslateUi(Form)
        QtCore.QMetaObject.connectSlotsByName(Form)

    def retranslateUi(self, Form):
        _translate = QtCore.QCoreApplication.translate
        Form.setWindowTitle(_translate("Form", "Pizza Order Form"))
        self.label.setText(_translate("Form", "Пицца:"))
        self.pushButton.setText(_translate("Form", "Заказать"))
        self.groupBox.setTitle(_translate("Form", "Доп ингредиент"))
        self.groupBox_2.setTitle(_translate("Form", "Размер"))

if __name__ == "__main__":
    import sys
    app = QtWidgets.QApplication(sys.argv)
    Form = QtWidgets.QWidget()
    ui = Ui_Form()
    ui.setupUi(Form)
    Form.show()
    sys.exit(app.exec())
