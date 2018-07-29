// slider
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


// slider certificates
$(document).ready(function(){
    $('.slider4').bxSlider({
        slideWidth: 150,
        minSlides: 2,
        maxSlides: 4,
        moveSlides: 1,
        slideMargin: 10
    });
});

// general for foundation
$(document).ready(function() {
    $(document).foundation();
});


// google mep
function initializeGoogleMap() {
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

if(window.google && google.maps) {
  google.maps.event.addDomListener(window, 'resize', initializeGoogleMap);
  google.maps.event.addDomListener(window, 'load', initializeGoogleMap)
}
// fancybox
$(document).ready(function() {
    $('.fancybox').fancybox();
});

// scale for google map

$(".scale").click(function(){
    $(".scale").toggleClass("minus")
    if ($(".contacts_banner").hasClass("scale_twice")) {
        $(".contacts_banner").removeClass("scale_twice")
    }
    else {
        $(".contacts_banner").addClass("scale_twice")
    }
})

// about member
$(".member").on("click", function(){
    $(this).parent().children().removeClass("active")
    $(this).addClass("active")
})

// header popup

$("#popup-1").on("click", function(){
    $(".popup-1").toggleClass("visible-popup")
})

$("#popup-2").on("click", function(){
    $(".popup-2").toggleClass("visible-popup")
})

$("#popup-3").on("click", function(){
    $(".popup-3").toggleClass("visible-popup")
})

// mobile-hamburger

$('#mobile-hamburger').click(function(){
    $('.top-bar').toggleClass('expanded')
    $('.index_menu').toggleClass('hide-menu')
    $('.menu_wrapper').toggleClass('hide-menu')
    $('#mobile-hamburger').toggleClass('opened')
})