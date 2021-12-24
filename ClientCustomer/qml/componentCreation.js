var component;
var sprite;

function createSpriteObjects(name, description, price, id) {
    component = Qt.createComponent("PizzaItem.qml");
    if (component.status === Component.Ready)
        finishCreation(name, description, price, id);
    else
        component.statusChanged.connect(finishCreation);
}

function finishCreation(name, description, price, id) {
    if (component.status === Component.Ready) {
        sprite = component.createObject(gridId, {textHeader: name, textMain: description, price: price, pizzaId: id});
        if (sprite === null) {
            // Error Handling
            console.log("Error creating object");
        }
    } else if (component.status === Component.Error) {
        // Error Handling
        console.log("Error loading component:", component.errorString());
    }
}
