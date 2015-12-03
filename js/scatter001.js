//DEFAULT
var datajson = []
for (var i = 0; i < 100; i++){
    datajson.push({
        total: Math.ceil(Math.random() * 10)
    });
}



getact = function (d) {     
	var sector = d.id;
	var ind = d.index;
	var sectores = [{"idsec":"Agropecuario","acts":[{"ind":1,"act":"Fermentación entérica"},{"ind":2,"act":"Manejo del estiercol"}]} , {"idsec":"Generación Eléctrica","acts":[{"ind":1,"act":"Generación Eléctrica"}]},{"idsec":"Industria Petróleo y Gas","acts":[{"ind":1,"act":"Petróleo & Gas"},{"ind":2,"act":"Cemento (combustion y proceso)"},{"ind":3,"act":"Cal (combustion y proceso)"},{"ind":4,"act":"Siderurgica (combustion y proceso)"},{"ind":5,"act":"Química (combustion y proceso)"},{"ind":6,"act":"Consumo de otros carbonatos (Vidrio Metalúrgica)"}]}, {"idsec":"Minería","acts":[{"ind":1,"act":"Minería"}]},{"idsec":"Residencial y Comercial","acts":[{"ind":1,"act":"Gas L.P. residencial"},{"ind":2,"act":"Gas Natural residencial y residencial"}]}];

    if( d.value ) {
        for(var k = 0; k < sectores.length; i++){
            if(sectores[k].idsec == sector){
                //if(!sectores[k].acts[ind]){var activity ="None";continue;}
                var activity = sectores[k].acts[ind].nombre;
                d.activity = activity;pa
            }
        }
    }
    return activity;
} 

//console.log(datajson)
//function(d) {
//       return Math.random() * 3;

var chart = c3.generate({
    bindto: '#chart',
    point: {
        r: function (d) {
            var k = d.index
            if ( d.value ) {
                var size = datajson[k]["total"];
                d.size = size;
                return size;
            }
        }
    },
    data: {
        xs: {
            'Agricultura': 'x1', 'Desechos': 'x2', 'Energía': 'x3', 'Procesos Industriales': 'x4'
        },
        columns: [
            ['Agricultura',15555],  ['x1',8105719], ['Desechos',311234,160.02,12424],  ['x2',3137759,774781,50794044], ['Energía',129856.18,53047.9,0,10131.09,1900.5,336.41,2916.82,8670.93,1922.54,2300.68],  ['x3',204585913,58582344,7459027,14216838,4379071,143884702,2792693,13974205,18364391,130715], ['Procesos Industriales',20770.33,3382.67,1324,133222],  ['x4',14216838,1305421,1155073,5394975]  ],
        type: 'scatter'
    },
    axis: {
       x: {
         min: 10,
         tick: {
         fit: false, // adjusts the chart not fit x ticks
         culling: {
                    max: 8 // the number of tick texts will be adjusted to less than this value
                }
            },
        label: { // ADD
          text: 'Valor Agregado Censal Bruto (miles de pesos)',
          position: 'outer-middle'
        }
      },
      y: {
       // padding: {top: 0, bottom: 0},
        label: { // ADD
          text: 'Emisiones totales de CO2 (gigatoneladas)',
          position: 'outer-middle'
        }
      }
    },
    tooltip: {
    contents: function (data, defaultTitleFormat, defaultValueFormat, color, sectores) {
        var $$ = this, config = $$.config,
            titleFormat = config.tooltip_format_title || defaultTitleFormat,
            nameFormat = config.tooltip_format_name || function (name) { return name; },
            valueFormat = config.tooltip_format_value || defaultValueFormat,
            text, i, title, value, size;

            //console.log(data.length)

            for (i = 0; i < data.length; i++) {
                if (! (data[i] && (data[i].value || data[i].value === 0))) { continue; }
 
                if (! text) {
                  title = titleFormat ? titleFormat(data[i].x) : data[i].x;
                  text = "<div id='tooltip' class='d3-tip'>";
                  size = data[i].size;
                  sector = data[i].id;
                  ind = data[i].index;
                  //activity= getact(data[i]);
                  //console.log(sector);
                  //console.log(ind);
                    // var sectores = [{"idsec": "Microsoft","acts":[{"indicador":1,"nombre":"Games"},{"indicador":2,"nombre":"Joysticks"}]},
                    //                 {"idsec": "IBM","acts":[{"indicador":1,"nombre":"Computers"},{"indicador":2,"nombre":"Laptops"}]}
                    //                 ];

                    // for(var k = 0; k < sectores.length; i++)
                    // {
                    //   if(sectores[k].idsec == sector)
                    //   {
                    //     activity = sectores[k].acts[ind].nombre ;
                    //     console.log(activity);
                    //   }
                    // }  

                       
                }

                value = valueFormat(data[i].value, data[i].ratio, data[i].id, data[i].index);
                text += "<span class='info'> Actividad economica " + sector +" " + ind + "</span><br>";
                text += "<span class='info'>"+ title + " pesos</span><br>";
                text += "<span class='info'>"+ size + " empleados </span><br>";
                text += "<span class='value'>" + value + " co2/kg </span>";
                text += "</div>";
            }
        return text;
        }
    }
});

var unloadUnits = false;
//click behaviors 


$('.unidad').click(function (){
    console.log("HOLA CLICK")
  if ( unloadUnits === false ) {
    unloadUnits = true;
    var datajson = []
    for (var i = 0; i < 100; i++){
        datajson.push({
            total: Math.ceil(Math.random() * 10)
        });
    }
    return; //this sets unload as true so we need to exit
  } else if ( unloadUnits === true ) { //makes sure the chart has stuff to show.
       unloadUnits = false;
    var datajson = []
    for (var i = 0; i < 100; i++){
        datajson.push({
            total: Math.ceil(Math.random() * 50)
        });
    } 
  }
  //eval(chart)
});

/*setTimeout(function () {
    chart.load({
        columns: [
            ["Microsoft", 10.2, 10.2, 10.2, 10.2, 10.2, 11.4, 10.3, 10.2, 10.2, 0.1, 0.2, 0.2, 0.1, 0.1, 0.2, 0.4, 0.4, 0.3, 0.3, 0.3, 0.2, 0.4, 0.2, 0.5, 0.2, 0.2, 0.4, 0.2, 0.2, 0.2, 0.2, 0.4, 0.1, 0.2, 0.2, 0.2, 0.2, 0.1, 0.2, 0.2, 0.3, 0.3, 0.2, 0.6, 0.4, 0.3, 0.2, 0.2, 0.2, 0.2],
        ]
    });
}, 3000);
*/

/*

tooltip: {
    contents: function (d) {
        if (d[0].value != null) {
            return d[0].size;
        }
    }
},
*/