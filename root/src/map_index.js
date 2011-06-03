var map,
	map2,
	map_shop,
	map_night;

function initialize() {
  var myLatlng = new google.maps.LatLng(13.820688,100.664889);
  var myOptions = {
    zoom: 10,
    center: myLatlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  }
  map_rest = new google.maps.Map(document.getElementById("map_canvas_rest"), myOptions);
  map_hotel = new google.maps.Map(document.getElementById("map_canvas2"), myOptions);
  map_shop = new google.maps.Map(document.getElementById("map_canvas_shop"), myOptions);
  map_night = new google.maps.Map(document.getElementById("map_canvas_night"), myOptions);
  
}