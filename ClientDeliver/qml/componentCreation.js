var component;
var sprite;

function createSpriteObjects(name, id_order, office_adress, order_adress) {
    component = Qt.createComponent("OrderItem.qml");
    if (component.status === Component.Ready)
        finishCreation(name, id_order, office_adress, order_adress);
    else
        component.statusChanged.connect(finishCreation);
}

function finishCreation(name, id_order, office_adress, order_adress) {
    if (component.status === Component.Ready) {
        sprite = component.createObject(gridId, {textHeader: name, id_order: id_order, office_adress: office_adress, order_adress: order_adress});
        if (sprite === null) {
            // Error Handling
            console.log("Error creating object");
        }
    } else if (component.status === Component.Error) {
        // Error Handling
        console.log("Error loading component:", component.errorString());
    }
}
