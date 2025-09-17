import QtQuick 2.11
import QtQuick.Layouts 1.11
import QtQuick.Shapes 1.9
import SddmComponents 2.0

Item {

    //Establishes root container, which fills the screen.
    id: root
    width: Screen.width
    height: Screen.height
    focus: true // global key listener

    //Layout mirroring for right to left languages, like Arabic
    LayoutMirroring.enabled: Qt.locale().textDirection == Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    //Keeps track of which session the user selected
    property int sessionIndex: session.index

    //Stores localized text for UI elements, such as login labels, error messages, prompts
    TextConstants { id: textConstants }


    Connections {
        target: sddm

        //Successful login
        onLoginSucceeded: {
            errorMessage.color = "red"
            errorMessage.text = textConstants.loginSucceeded
        }

        //Failed login
        onLoginFailed: {
            password.text = ""
            errorMessage.color = "red"
            errorMessage.text = textConstants.loginFailed
        }

        //Other information message at login screen
        onInformationMessage: {
            errorMessage.color = "red"
            errorMessage.text = message
        }
    }


    //Shows the background image specified in the config file (theme.conf) unless failed, in which case shows default.
    //Default background image can be changed in config file
    Background {
        anchors.fill: parent
        source: config.background
        fillMode: Image.PreserveAspectCrop
        onStatusChanged: {
            if (status == Image.Error && source != config.defaultBackground) {
                source = config.defaultBackground
            }
        }
    }

    //Universal watch for keys to reboot and shutdown
    Keys.onPressed: (event) => {

        //If F1 pressed, shutdown the system
        if (event.key === Qt.Key_F1) {
            sddm.powerOff(); event.accepted = true
        }

        //If F2 pressed, reboot the system
        if (event.key === Qt.Key_F2) {
            sddm.reboot(); event.accepted = true
        }

        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter){
            sddm.login(name.text, password.text, sessionIndex); event.accepted = true
        }
    }

    //Reboot/shutdown label in top corner
    Text {
        text: "F1 shutdown F2 reboot"
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 10 //Padding from the edge
        font.pixelSize: 14
        font.family: config.font
        color: "white"
    }


//Main window elements

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        //visible: primaryScreen

        //New login box -- similar to the ly greeter
        Shape {
            id: login_rectangle
            anchors.centerIn: parent

            //anchors.centerIn already centers this element
            //x: 0
            //y: 0
            width: root.width / 2
            height: root.height / 3

            ShapePath{
                strokeWidth: 2
                strokeColor: "white"
                fillColor: "transparent"

                startX: 0; startY: 0
                PathLine { x: login_rectangle.width; y: 0 }
                PathLine { x: login_rectangle.width; y: login_rectangle.height }
                PathLine { x: 0; y: login_rectangle.height }
                PathLine { x: 0; y: 0 }
            }



            Column {
                id: mainColumn
                anchors.centerIn: parent
                spacing: 12
                width: parent.width

                //Row for hostname
                Row {
                    width: parent.width
                    height: 30

                    anchors.horizontalCenter: parent.horizontalCenter

                    //Hostname
                    Text{
                        text: config.hostname
                        font.pixelSize: 14
                        font.family: config.font
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }


                //Username row
                Row {
                    spacing: 8
                    width: parent.width

                    //Entry box label
                    Text{
                        text: "login"
                        width: parent.width * 0.3
                        horizontalAlignment: Text.AlignRight
                        verticalAlignment: Text.AlignVCenter
                        color: "white"
                        font.pixelSize: 14
                        font.family: config.font
                    }


                    //Username entry box
                    TextBox {
                        id: name
                        width: parent.width * 0.5
                        height: 30
                        text: userModel.lastUser
                        font.pixelSize: 14
                        font.family: config.font
                        color: "white"
                        anchors.verticalCenter: parent.verticalCenter


                        KeyNavigation.backtab: password; KeyNavigation.tab: password

                        Keys.onPressed: {
                            if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                                sddm.login(name.text, password.text, sessionIndex)
                                event.accepted = true
                                }
                        }
                    }
                }



                //Password row
                Row {
                    spacing: 8
                    width: parent.width

                    //Entry box label
                    Text{
                        text: "password"
                        width: parent.width * 0.3
                        horizontalAlignment: Text.AlignRight
                        verticalAlignment: Text.AlignVCenter
                        color: "white"
                        font.pixelSize: 14
                        font.family: config.font


                    }


                    // Password
                    PasswordBox {
                        id: password
                        width: parent.width * 0.5
                        height: 30
                        font.pixelSize: 14
                        font.family: config.font
                        color: "white"
                        anchors.verticalCenter: parent.verticalCenter


                        KeyNavigation.backtab: name; KeyNavigation.tab: name

                        Keys.onPressed: {
                            if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                                sddm.login(name.text, password.text, sessionIndex)
                                event.accepted = true
                            }
                        }
                    }

                }





                //Row for error messages
                Row {
                    spacing: 8
                    width: parent.width

                    // Error / Info Message
                    Text {
                        id: errorMessage
                        horizontalAlignment: Text.AlignRight
                        verticalAlignment: Text.AlignVCenter
                        text: "" //empty unless error message
                        font.pixelSize: 10
                        font.family: config.font
                    }
                }

            }
        }
    }




    Component.onCompleted: {
        if (name.text == "")
            name.focus = true
        else
            password.focus = true
    }
}
