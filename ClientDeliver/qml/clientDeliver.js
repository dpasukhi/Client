                             
    ymaps.ready(function () { 
        var myMap = new ymaps.Map('map', { 
            center: [56.29, 43.98], 
            zoom: 16, 
            // Добавим панель маршрутизации.                                                  
            controls: ['routePanelControl']                                                 
        });                                                                                   
                                                                                              
        var control = myMap.controls.get('routePanelControl');                              
        //control.routePanel.geolocate('from');                                             
        //control.state.set('expanded', true);                                              
                                                                                              
        control.routePanel.state.set({                                                        
            type: 'auto',                                                                   
            fromEnabled: true,                                                                
            from: office_address,                                                             
            to: order_address,                                                                
            toEnabled: false                                                                  
        });                                                                                   
                                                                                              
        // Зададим опции панели для построения машрутов.                                      
        control.routePanel.options.set({                                                      
            allowSwitch: true,                                                                
            reverseGeocoding: true,                                                           
            types: { auto: true, masstransit: false, pedestrian: false, taxi: false }         
        });                                                                                   
                                                                                              
        var trafficControl = new ymaps.control.TrafficControl({ state: {                      
                providerKey: 'traffic#actual',                                              
                trafficShown: true                                                            
            }});                                                                              
        myMap.controls.add(trafficControl);                                                   
        var switchPointsButton = new ymaps.control.Button({                                   
            data: {content: "Поменять местами", title: "Поменять точки местами"},         
            options: {selectOnClick: false, maxWidth: 160}                                    
        });                                                                                   
        switchPointsButton.events.add('click', function () {                                
            control.routePanel.switchPoints();                                                
        });                                                                                   
        myMap.controls.add(switchPointsButton);                                               
                                                                                              
        objectManager = new ymaps.ObjectManager({                                             
            clusterize: true,                                                                 
            gridSize: 32,                                                                     
            clusterDisableClickZoom: true                                                     
        });                                                                                   
        objectManager.objects.options.set('preset', 'islands#greenDotIcon');              
        objectManager.clusters.options.set('preset', 'islands#greenClusterIcons');        
        myMap.geoObjects.add(objectManager);                                                  
                                                                                              
        //$.ajax({                                                                            
        //url: "data.json"                                                                  
        //}).done(function(data) {                                                            
        //objectManager.add(data);                                                            
        //});                                                                                 
    });                                                                                       

