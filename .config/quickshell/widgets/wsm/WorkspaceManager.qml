pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

PanelWindow { // qmllint disable uncreatable-type
    id: root
    color: "transparent"
    focusable: true

    // Appearance
    property int totalWorkspaces: 5
    property int globalRadius: 5
    property int iconSize: 32
    property real zoom: 1
    property int workspaceContainerSpacing: 5
    property int toplevelPadding: 15
    property color workspacesBackgroundColor: "#1B1B1B"
    property color workspaceColor: "transparent"
    property color workspaceBorderColor: "#32302F"
    property color workspaceContainsDragColor: "#32302F"
    property color windowColor: "#504945"
    property color fullscreenWindowColor: "transparent"
    property color fullscreenTextColor: "#EA6962"
    property color textColor: "#D4BE98"
    property bool enabledRandomWindowColor: false
    property bool displayWindowTitle: false
    // End of Appearance

    property bool debug: false

    function log(msg) {
        if (debug)
            console.log(msg);
    }

    function getAppIcon(name: string, check: bool): string {
        const icon = DesktopEntries.heuristicLookup(name)?.icon;
        if (check != undefined)
            return Quickshell.iconPath(icon, check);
        return Quickshell.iconPath(icon);
    }

    property var windowColors: ({})
    property var activeWorkspaces: Hyprland.workspaces.values
    function computeWorkspaces() {
        let base = Array.from(Hyprland.workspaces.values || []).filter(w => w.id > 0);
        for (let i = 1; i <= totalWorkspaces; ++i)
            if (!base.some(w => w.id === i))
                base.push({
                    id: i
                });
        base.sort((a, b) => a.id - b.id);
        let specials = Array.from(Hyprland.workspaces.values || []).filter(w => w.id < 0);
        return base.concat(specials);
    }
    property var workspaces: computeWorkspaces()

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
        color: root.workspacesBackgroundColor
        radius: root.globalRadius
        implicitWidth: parent.width
        implicitHeight: parent.height

        RowLayout {
            id: workspacesContainer
            anchors.centerIn: parent
            spacing: root.workspaceContainerSpacing
            Layout.fillWidth: true
            Layout.fillHeight: true

            Repeater {
                model: root.workspaces

                delegate: ColumnLayout {
                    id: workspacesColumn
                    required property var modelData

                    Rectangle {
                        id: workspace
                        border.color: root.workspaceBorderColor
                        radius: root.globalRadius
                        color: dropArea.containsDrag ? root.workspaceContainsDragColor : root.workspaceColor

                        implicitWidth: (root.currentMonitor?.width / (root.workspaces.length + 1)) * root.zoom
                        implicitHeight: (root.currentMonitor?.height / (root.workspaces.length + 1)) * root.zoom

                        property var workspaceData: workspacesColumn.modelData
                        property var toplevels: workspaceData.toplevels?.values.filter(t => t.lastIpcObject && t.lastIpcObject.at && t.lastIpcObject.size) ?? []

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
                                const src = event.source;
                                if (!src)
                                    return;
                                src.parent = parent;
                                src.x = Qt.binding(() => src.isFullscreen ? (workspace.width - root.iconSize) / 2 : ((src.at[0] ?? 0) - workspace.minX) * workspace.scaleX);
                                src.y = Qt.binding(() => src.isFullscreen ? (workspace.height - root.iconSize) / 2 : ((src.at[1] ?? 0) - workspace.minY) * workspace.scaleY);
                                var address = src.address;
                                var name = src.name;

                                if (src.parent.workspaceData.name) {
                                    Hyprland.dispatch(`movetoworkspacesilent ${src.parent.workspaceData.name}, address:${address}`);
                                    console.log(`Special: ${src.parent.workspaceData.name}`);
                                } else {
                                    Hyprland.dispatch(`movetoworkspacesilent ${workspace.workspaceData.id}, address:${address}`);
                                }
                                Hyprland.refreshToplevels();
                                root.log(`Moved ${name} -> workspace ${workspace.workspaceData.id}`);
                            }
                        }

                        Repeater {
                            model: workspace.workspaceData.toplevels ?? []
                            delegate: Rectangle {
                                id: window
                                required property var modelData

                                property var windowData: modelData
                                property var name: windowData.lastIpcObject?.class
                                property var address: windowData.lastIpcObject?.address
                                property var at: windowData.lastIpcObject?.at ?? [0, 0]
                                property var size: windowData.lastIpcObject?.size ?? [1, 1]
                                property bool isFullscreen: windowData.lastIpcObject?.fullscreen ?? false

                                property bool displayIcon: window.width >= 16 && window.height >= 16
                                property bool displayTitle: root.displayWindowTitle && window.width >= root.iconSize && window.height >= root.iconSize

                                property Item initialParent: parent
                                property int initialX: 0
                                property int initialY: 0

                                color: {
                                    if (isFullscreen) {
                                        return root.fullscreenWindowColor;
                                    }
                                    if (root.enabledRandomWindowColor) {
                                        if (!(address in root.windowColors))
                                            root.windowColors[address] = Qt.rgba(Math.random(), Math.random(), Math.random(), 0.8);
                                        return root.windowColors[address];
                                    } else {
                                        return root.windowColor;
                                    }
                                }

                                // TODO: Fullscreen windows size should take the remaning space of the workspace
                                // Either by being able to query last size and position of fullscreened windows

                                // NOTE: (Current behaviour)
                                // Another option would be setting window size equals to the icon and center it
                                // allowing users to also drag windows beneath it

                                x: isFullscreen ? (workspace.width - root.iconSize) / 2 : ((at[0] ?? 0) - workspace.minX) * workspace.scaleX
                                y: isFullscreen ? (workspace.height - root.iconSize) / 2 : ((at[1] ?? 0) - workspace.minY) * workspace.scaleY
                                z: isFullscreen ? 99 : 0
                                width: isFullscreen ? root.iconSize : ((size[0] ?? 50)) * workspace.scaleX
                                height: isFullscreen ? root.iconSize : ((size[1] ?? 50)) * workspace.scaleY
                                radius: root.globalRadius ?? 0

                                Drag.active: mouseArea.drag.active
                                Drag.hotSpot.x: width / 2
                                Drag.hotSpot.y: height / 2

                                Column {
                                    anchors.centerIn: parent
                                    width: parent.width

                                    Image {
                                        visible: window.displayIcon
                                        source: root.getAppIcon(window.name, true)
                                        fillMode: Image.PreserveAspectFit
                                        sourceSize.width: window.width >= root.iconSize ? root.iconSize : root.iconSize / 2
                                        sourceSize.height: window.height >= root.iconSize ? root.iconSize : root.iconSize / 2
                                        anchors.horizontalCenter: parent.horizontalCenter
                                    }

                                    Text {
                                        property real padding: 20
                                        visible: window.displayTitle && !window.isFullscreen
                                        text: window.windowData.title ?? "?"
                                        color: window.isFullscreen ? root.fullscreenTextColor : root.textColor
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
                                        root.log(`Initial parent: ${window.initialParent}`);
                                        root.log(`Initial position: ${window.x}, ${window.y}`);
                                        window.initialParent = window.parent;
                                        window.initialX = window.x;
                                        window.initialY = window.y;
                                        const globalPos = window.mapToItem(dragOverlay, 0, 0);
                                        window.parent = dragOverlay;
                                        window.x = globalPos.x;
                                        window.y = globalPos.y;
                                    }
                                    onReleased: {
                                        var target = window.Drag.target;
                                        if (!target) {
                                            window.parent = window.initialParent;
                                            window.x = Qt.binding(() => window.isFullscreen ? (workspace.width - root.iconSize) / 2 : ((window.at[0] ?? 0) - workspace.minX) * workspace.scaleX);
                                            window.y = Qt.binding(() => window.isFullscreen ? (workspace.height - root.iconSize) / 2 : ((window.at[1] ?? 0) - workspace.minY) * workspace.scaleY);
                                        }
                                        cursorShape = Qt.PointingHandCursor;
                                        window.Drag.drop();
                                        root.log(`New parent: ${window.initialParent}`);
                                        root.log(`New position: ${window.initialX}, ${window.initialY}`);
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
