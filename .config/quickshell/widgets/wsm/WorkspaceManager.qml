import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

PanelWindow {
    id: toplevel
    color: "transparent"
    focusable: true

    // Appearance
    property int totalWorkspaces: 5
    property int globalRadius: 5
    property int iconSize: 32
    property real zoom: 1
    property int toplevelPadding: 15
    property int workspaceContainerSpacing: 5
    property color workspacesBackgroundColor: "#1B1B1B"
    property color workspaceColor: "transparent"
    property color workspaceBorderColor: "#32302F"
    property color workspaceContainsDragColor: "#32302F"
    property color windowColor: "#504945"
    property color fullscreenWindowColor: "transparent"
    property color fullscreenTextColor: "#EA6962"
    property color textColor: "#D4BE98"
    property bool displayWindowTitle: false
    property bool enabledRandomWindowColor: false
    // End of Appearance

    property bool debug: false

    property var log: debug ? function (msg) {
        console.log(msg);
    } : function (msg) {}

    function getAppIcon(name: string, check: bool): string {
        const icon = DesktopEntries.heuristicLookup(name)?.icon;
        if (check != undefined)
            return Quickshell.iconPath(icon, check);
        return Quickshell.iconPath(icon);
    }

    property var windowColors: ({})
    property var activeWorkspaces: Hyprland.workspaces.values
    property var workspaces: {
        if (totalWorkspaces > activeWorkspaces.length) {
            let base = Array.from(Hyprland.workspaces.values || []);
            for (let i = 1; i <= totalWorkspaces; ++i)
                if (!base.some(w => w.id === i))
                    base.push({
                        id: i
                    });
            return base.sort((a, b) => a.id - b.id);
        } else {
            return activeWorkspaces;
        }
    }
    property var currentMonitor: Hyprland.focusedMonitor

    implicitWidth: workspacesContainer.width + toplevelPadding
    implicitHeight: workspacesContainer.height + toplevelPadding

    Connections {
        target: Hyprland
        function onRawEvent(event) {
            Hyprland.refreshToplevels();
        }
    }

    Item {
        focus: true
        Keys.onPressed: event => {
            if (event.key == Qt.Key_Escape) {
                Qt.quit();
            }
        }
    }

    Item {
        id: dragOverlay
        anchors.fill: parent
        z: 99
    }

    Rectangle {
        id: workspacesBackground
        anchors.centerIn: parent
        color: workspacesBackgroundColor
        radius: globalRadius
        implicitWidth: parent.width
        implicitHeight: parent.height

        RowLayout {
            id: workspacesContainer
            anchors.centerIn: parent
            spacing: workspaceContainerSpacing
            Layout.fillWidth: true
            Layout.fillHeight: true

            Repeater {
                model: workspaces

                delegate: ColumnLayout {

                    Rectangle {
                        id: workspace
                        border.color: workspaceBorderColor
                        radius: globalRadius
                        color: dropArea.containsDrag ? workspaceContainsDragColor : workspaceColor

                        implicitWidth: (currentMonitor?.width / (workspaces.length + 1)) * zoom
                        implicitHeight: (currentMonitor?.height / (workspaces.length + 1)) * zoom

                        property var workspaceData: modelData
                        property var toplevels: modelData.toplevels?.values.filter(t => t.lastIpcObject && t.lastIpcObject.at && t.lastIpcObject.size) ?? []

                        property int minX: toplevels.length ? Math.min(...toplevels.map(t => t.lastIpcObject.at[0])) : 0
                        property int minY: toplevels.length ? Math.min(...toplevels.map(t => t.lastIpcObject.at[1])) : 0
                        property int maxX: toplevels.length ? Math.max(...toplevels.map(t => t.lastIpcObject.at[0] + (t.lastIpcObject.size[0] || 1))) : 1
                        property int maxY: toplevels.length ? Math.max(...toplevels.map(t => t.lastIpcObject.at[1] + (t.lastIpcObject.size[1] || 1))) : 1

                        property real scaleX: width / (maxX - minX)
                        property real scaleY: height / (maxY - minY)

                        DropArea {
                            id: dropArea
                            anchors.fill: parent

                            onDropped: event => {
                                const address = event.source.windowAddress;
                                const name = event.source.windowClass;
                                Hyprland.dispatch(`movetoworkspacesilent ${modelData.id}, address:${address}`);
                                Hyprland.refreshToplevels();
                                log(`Moved ${name} -> workspace ${modelData.id}`);
                            }
                        }

                        Repeater {
                            model: modelData.toplevels ?? []
                            delegate: Rectangle {
                                id: window

                                property var windowData: modelData
                                property var windowClass: windowData.lastIpcObject.class
                                property var windowAt: windowData.lastIpcObject?.at ?? [0, 0]
                                property var windowAddress: windowData.lastIpcObject.address
                                property bool windowFullscreen: windowData.lastIpcObject?.fullscreen ?? false
                                property var windowSize: windowData.lastIpcObject?.size ?? [1, 1]

                                property bool displayIcon: window.width >= 16 && window.height >= 16
                                property bool displayTitle: displayWindowTitle && window.width >= iconSize && window.height >= iconSize

                                property var initialParent: parent
                                property int initialX: 0
                                property int initialY: 0

                                color: {
                                    if (windowFullscreen) {
                                        return fullscreenWindowColor;
                                    }
                                    if (enabledRandomWindowColor) {
                                        if (!(windowAddress in toplevel.windowColors))
                                            toplevel.windowColors[windowAddress] = Qt.rgba(Math.random(), Math.random(), Math.random(), 0.8);
                                        return toplevel.windowColors[windowAddress];
                                    } else {
                                        return windowColor;
                                    }
                                }

                                // TODO: Fullscreen windows should take the remaning space of the workspace
                                // Maybe by being able to query last size and position of fullscreened windows

                                // NOTE: (Current behaviour)
                                // Another option would be setting window size equals to the icon and center it
                                // allowing users to also drag windows beneath it

                                x: windowFullscreen ? (parent.width - iconSize) / 2 : ((windowAt[0] ?? 0) - parent.minX) * parent.scaleX
                                y: windowFullscreen ? (parent.height - iconSize) / 2 : ((windowAt[1] ?? 0) - parent.minY) * parent.scaleY
                                z: windowFullscreen ? 99 : 0
                                width: windowFullscreen ? iconSize : ((windowSize[0] ?? 50)) * parent.scaleX
                                height: windowFullscreen ? iconSize : ((windowSize[1] ?? 50)) * parent.scaleY
                                radius: globalRadius ?? 0

                                Drag.active: mouseArea.drag.active
                                Drag.hotSpot.x: width / 2
                                Drag.hotSpot.y: height / 2

                                Column {
                                    anchors.centerIn: parent
                                    width: parent.width

                                    Image {
                                        visible: displayIcon
                                        source: getAppIcon(windowClass, true)
                                        fillMode: Image.PreserveAspectFit
                                        sourceSize.width: window.width >= iconSize ? iconSize : iconSize / 2
                                        sourceSize.height: window.height >= iconSize ? iconSize : iconSize / 2
                                        anchors.horizontalCenter: parent.horizontalCenter
                                    }

                                    Text {
                                        property real padding: 20
                                        visible: displayTitle && !windowFullscreen
                                        text: windowData.title ?? "?"
                                        color: windowFullscreen ? fullscreenTextColor : textColor
                                        width: parent.width
                                        leftPadding: padding
                                        rightPadding: padding
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        elide: Text.ElideRight
                                        horizontalAlignment: Text.AlignHCenter
                                    }
                                }

                                MouseArea {
                                    id: mouseArea
                                    anchors.fill: parent
                                    drag.target: window
                                    cursorShape: Qt.PointingHandCursor

                                    onPressed: mouse => {
                                        cursorShape = Qt.ClosedHandCursor;
                                        log(`Initial parent: ${window.initialParent}`);
                                        log(`Initial position: ${window.x}, ${window.y}`);
                                        window.initialParent = window.parent;
                                        window.initialX = window.x;
                                        window.initialY = window.y;
                                        const globalPos = window.mapToItem(dragOverlay, 0, 0);
                                        window.parent = dragOverlay;
                                        window.x = globalPos.x;
                                        window.y = globalPos.y;
                                    }
                                    onReleased: {
                                        if (!window.Drag.target || window.Drag.target.parent.workspaceData.id == modelData.workspace.id) {
                                            window.parent = window.initialParent;
                                            if (windowFullscreen) {
                                                window.x = (workspace.width - iconSize) / 2;
                                                window.y = (workspace.height - iconSize) / 2;
                                            } else {
                                                window.x = Qt.binding(() => ((windowAt[0] ?? 0) - workspace.minX) * workspace.scaleX);
                                                window.y = Qt.binding(() => ((windowAt[1] ?? 0) - workspace.minY) * workspace.scaleY);
                                            }
                                        }
                                        cursorShape = Qt.PointingHandCursor;
                                        parent.Drag.drop();
                                        log(`New parent: ${window.initialParent}`);
                                        log(`New position: ${window.initialX}, ${window.initialY}`);
                                        Hyprland.refreshToplevels();
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
