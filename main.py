import pymysql
import PyQt6
from PyQt6.QtWidgets import QMessageBox
from designer import *

connection = pymysql.Connection(host="localhost", user="root", password="", db="online_pizzeria")
cursor = connection.cursor()

class Pizzam(QtWidgets.QWidget, Ui_Form):
    def __init__(self):
        super(Pizzam, self).__init__()
        self.setupUi(self)

        self.comboBox.currentTextChanged.connect(self.text_ch)

        cursor.execute("select * from pizza")
        zxc = cursor.fetchall()
        for i in zxc:
            self.comboBox.addItem(f"{i[1]}")

        cursor.execute("select * from ingred")
        zxc = cursor.fetchall()
        h = 20
        self.checks = []
        for i in zxc:
            checkBox = QtWidgets.QCheckBox(parent=self.groupBox)
            checkBox.setGeometry(QtCore.QRect(10, h, 271, 17))
            checkBox.setText(f"{i[1]}")
            self.checks.append(checkBox)
            checkBox.setObjectName(f"chB_{i[0]}")

            h+=20
        self.groupBox.setGeometry(10, 60, 571, h)
        h+=80
        hi = 20


        self.pizza = self.comboBox.currentText()
        cursor.execute(f"select id from pizza where name = '{self.pizza}'")
        self.pizza = cursor.fetchone()[0]

        self.sz = ""

        cursor.execute("select * from sizes order by name")
        zxc = cursor.fetchall()
        for i in zxc:
            radioButton = QtWidgets.QRadioButton(parent=self.groupBox_2)
            radioButton.setGeometry(QtCore.QRect(10, hi, 501, 17))
            radioButton.setText(f"{i[1]}, {i[2]}р")
            radioButton.setObjectName(f"rB{i[0]}")
            radioButton.toggled.connect(self.on_toggle)
            hi+=20
        self.groupBox_2.setGeometry(10, h, 571, hi)
        h +=hi
        h+=20
        self.pushButton.setGeometry(450, h, 211, 23)
        h+=40
        self.resize(671, h)

        self.pushButton.clicked.connect(self.on_click)

    def on_toggle(self, checked):
        rb = self.groupBox_2.sender()
        if checked:
            self.sz = rb.text()[0:2]
            cursor.execute(f"select id from sizes where name = '{self.sz}'")
            self.sz = cursor.fetchone()[0]

    def text_ch(self):
        self.pizza = self.comboBox.currentText()
        cursor.execute(f"select id from pizza where name = '{self.pizza}'")
        self.pizza = cursor.fetchone()[0]

    def on_click(self):
        checked = ','.join([checkbox.text() for checkbox in self.checks if checkbox.isChecked()])
        chup = list(checked.split(","))
        cursor.execute(
            f"INSERT INTO `pizza_order` (`id`, `pizza_id`, `size_id`) VALUES (NULL, '{self.sz}', '{self.pizza}')")
        connection.commit()
        cursor.execute("SELECT LAST_INSERT_ID()")
        dop = cursor.fetchone()[0]
        connection.commit()
        kom = []
        for i in chup:
            cursor.execute(f"SELECT id FROM ingred WHERE name = '{i}'")
            kom.append(cursor.fetchone()[0])
        for j in range(len(kom)):
            cursor.execute(
                f"INSERT INTO `ingred_dop` (`id`, `order_id`, `ingred_id`) VALUES (NULL, '{dop}', '{kom[j]}')")
            connection.commit()

        cursor.execute(f"SELECT name FROM pizza WHERE id = '{self.pizza}'")
        pizza_name = cursor.fetchone()[0]
        cursor.execute(f"SELECT name FROM sizes WHERE id = '{self.sz}'")
        size_name = cursor.fetchone()[0]
        ingredient_names = [i for i in chup]

        message = "<center><b>ЧЕК !</b></center>\n"
        message += f"<b>Ваша пицца:</b> {pizza_name}\n"
        message += f"<b>Размер:</b> {size_name}\n"
        message += f"<b>Доп ингредиент:</b> {', '.join(ingredient_names)}\n"

        # message += f"Ордер ID: {dop}\n"



        QMessageBox.information(self, "ЧЕК", message)

if __name__ == "__main__":
    import sys
    app = QtWidgets.QApplication(sys.argv)
    Form = Pizzam()
    Form.show()
    sys.exit(app.exec())