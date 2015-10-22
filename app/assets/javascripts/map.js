$(function() {

var greenIcon = L.icon({
    iconUrl: 'http://leafletjs.com/docs/images/leaf-green.png',
    shadowUrl: 'http://leafletjs.com/docs/images/leaf-shadow.png',

    iconSize:     [38, 95], // size of the icon
    shadowSize:   [50, 64], // size of the shadow
    iconAnchor:   [22, 94], // point of the icon which will correspond to marker's location
    shadowAnchor: [4, 62],  // the same for the shadow
    popupAnchor:  [-3, -76] // point from which the popup should open relative to the iconAnchor
});

	var map = L.map('map').setView([23.38, -102.13], 5);
	
	L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
		attribution : 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> | <a herf="http://opi.la/">OPI</a>',
		maxZoom : 18
	}).addTo(map);

	var df = L.marker([19.00, -102.36],{icon: greenIcon}).bindPopup('Ciudad de México}.'),
	    morelia = L.marker([19.70, -101.19],{icon: greenIcon}).bindPopup('Morelia.'),
	    oaxaca = L.marker([17.04, -96.43],{icon: greenIcon}).bindPopup('Oaxaca.');

	var cities = L.layerGroup([df, morelia, oaxaca]);
	var overlayMaps = {
		"Cities" : cities
	};
	

	// control that shows state info on hover
	var info = L.control();

L.control.layers(overlayMaps).addTo(map);

	info.onAdd = function(map) {
		this._div = L.DomUtil.create('div', 'info');
		this.update();
		return this._div;
	};

	info.update = function(props) {
		this._div.innerHTML = '<h4>Cambio climático en México</h4>' + ( props ? '<b>' + props.cve + '</b><br />' + props.nom_ent : 'Selecciona un estado');
	};

	info.addTo(map);

	// get color depending on population density value
	function getColor(d) {
		return d > 1000 ? '#800026' : d > 500 ? '#BD0026' : d > 200 ? '#E31A1C' : d > 100 ? '#FC4E2A' : d > 50 ? '#FD8D3C' : d > 20 ? '#FEB24C' : d > 10 ? '#FED976' : '#FFEDA0';
	}

	function style(feature) {
		return {
			weight : 2,
			opacity : 1,
			color : 'white',
			dashArray : '3',
			fillOpacity : 0.7,
			fillColor : getColor(feature.properties.density)
		};
	}

	function highlightFeature(e) {
		var layer = e.target;

		layer.setStyle({
			weight : 3,
			color : '#666',
			dashArray : '',
			fillOpacity : 0.7
		});

		if (!L.Browser.ie && !L.Browser.opera) {
			layer.bringToFront();
		}

		info.update(layer.feature.properties);
	}

	var geojson;

	function resetHighlight(e) {
		geojson.resetStyle(e.target);
		info.update();
	}

	function zoomToFeature(e) {
		map.fitBounds(e.target.getBounds());
	}

	function onEachFeature(feature, layer) {
		layer.on({
			mouseover : highlightFeature,
			mouseout : resetHighlight,
			click : zoomToFeature
		});
	}

	geojson = L.geoJson(entidad, {
		style : style,
		onEachFeature : onEachFeature
	}).addTo(map);

	map.attributionControl.addAttribution('Fuente :<a href="http://datos.gob.mx">Datos abiertos</a>');

	var legend = L.control({
		position : 'bottomright'
	});

	legend.onAdd = function(map) {

		var div = L.DomUtil.create('div', 'info legend'),
		    grades = [0, 10, 20, 50, 100, 200, 500, 1000],
		    labels = [],
		    from,
		    to;

		for (var i = 0; i < grades.length; i++) {
			from = grades[i];
			to = grades[i + 1];

			labels.push('<i style="background:' + getColor(from + 1) + '"></i> ' + from + ( to ? '&ndash;' + to : '+'));
		}

		div.innerHTML = labels.join('<br>');
		return div;
	};

	legend.addTo(map);

});

