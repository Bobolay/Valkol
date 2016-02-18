// 1
$(document).ready(function(){
    $('.bxslider').bxSlider({
        nextSelector: '.slider-next',
        prevSelector: '.slider-prev',
        nextText: '>',
        prevText: '<',
        pager: true,
        auto: true,
        pause: 5000
    });
});


// 2
$(document).ready(function(){
    $('.slider4').bxSlider({
        slideWidth: 300,
        minSlides: 4,
        maxSlides: 4,
        moveSlides: 1,
        slideMargin: 10
    });
});

// 3
$(document).ready(function() {
    $(document).foundation();
});

// 4
function initialize() {
    var styles = [
        {
            stylers: [
                { saturation: -100 }
            ]
        }
    ];
    var styledMap = new google.maps.StyledMapType(styles, {name: "Styled Map"});
    var mapOptions = {
        zoom: 15,
        center: new google.maps.LatLng(49.830421, 24.0309108),
        panControl:false,
        zoomControl:false,
        mapTypeControl:false,
        scaleControl:false,
        streetViewControl:false,
        overviewMapControl:false,
        rotateControl:false,
        mapTypeControlOptions:{
            mapTypeIds: [google.maps.MapTypeId.ROADMAP, "map_style"]
        }
    };
    var map = new google.maps.Map(document.getElementById('location-canvas'),
        mapOptions);
    var marker = new google.maps.Marker({
        map: map,
        draggable: true,
        position: new google.maps.LatLng(49.830421, 24.0309108)
    });
    map.mapTypes.set('map_style', styledMap);
    map.setMapTypeId('map_style');
}
google.maps.event.addDomListener(window, 'resize', initialize);
google.maps.event.addDomListener(window, 'load', initialize)

// 5
$(document).ready(function() {
    $('.fancybox').fancybox();
});

// 6
var $scale_button = $('#scale');
$scale_button.on ("click", function increaseHeight(){
    var map = document.getElementById("location-canvas");
    var height = map.offsetHeight;
    var newHeight = height + 250;
    map.style.height = newHeight + 'px';
})