ymaps.ready(function () {
    var myMap = new ymaps.Map('map', {
        center: [55.753994, 37.622093],
        zoom: 9,
        controls: ['routeButtonControl']
    });

    var control = myMap.controls.get('routeButtonControl');
    control.routePanel.geolocate('to');
    control.state.set('expanded', true);
});
