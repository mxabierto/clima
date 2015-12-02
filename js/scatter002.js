//DEFAULT
var datajson = []
for (var i = 0; i < 100; i++){
    datajson.push({
        total: Math.ceil(Math.random() * 10)
    });
}

//CATALOGO
//var catalogo = JSON.parse('{{"idsec":"Agropecuario","acts":"[{"ind":1,"act":"Fermentación entérica"},{"ind":2,"act":"Manejo del estiercol"},{"ind":3,"act":"Suelos agricolas, quemas agricolas y cultivos de arroz"}]"} ],[ {"idsec":"Generación Eléctrica","acts":"[{"ind":1,"act":"Generación Eléctrica"}]"} ],[ {"idsec":"Industria Petróleo y Gas","acts":"[{"ind":1,"act":"Petróleo & Gas"},{"ind":2,"act":"Cemento (combustion y proceso)"},{"ind":3,"act":"Cal (combustion y proceso)"},{"ind":4,"act":"Siderurgica (combustion y proceso)"},{"ind":5,"act":"Química (combustion y proceso)"},{"ind":6,"act":"Consumo de otros carbonatos (Vidrio Metalúrgica)"}]"} ],[ {"idsec":"Minería","acts":"[{"ind":1,"act":"Minería"}]"} ],[ {"idsec":"Residencial y Comercial","acts":"[{"ind":1,"act":"Gas L.P. residencial"},{"ind":2,"act":"Gas Natural residencial y residencial"}]"}}')

// getact = function (d) {     var sector = d.id;
//                             var ind = d.index;
//                             var sectores = [ {"idsec":"Agropecuario","acts":"[{"ind":1,"act":"Fermentación entérica"},{"ind":2,"act":"Manejo del estiercol"},{"ind":3,"act":"Suelos agricolas, quemas agricolas y cultivos de arroz"}]"} ],[ {"idsec":"Generación Eléctrica","acts":"[{"ind":1,"act":"Generación Eléctrica"}]"} ],[ {"idsec":"Industria Petróleo y Gas","acts":"[{"ind":1,"act":"Petróleo & Gas"},{"ind":2,"act":"Cemento (combustion y proceso)"},{"ind":3,"act":"Cal (combustion y proceso)"},{"ind":4,"act":"Siderurgica (combustion y proceso)"},{"ind":5,"act":"Química (combustion y proceso)"},{"ind":6,"act":"Consumo de otros carbonatos (Vidrio Metalúrgica)"}]"} ],[ {"idsec":"Minería","acts":"[{"ind":1,"act":"Minería"}]"} ],[ {"idsec":"Residencial y Comercial","acts":"[{"ind":1,"act":"Gas L.P. residencial"},{"ind":2,"act":"Gas Natural residencial y residencial"}]"} ];
//                             if ( d.value ) {
//                                 for(var k = 0; k < sectores.length; i++){
//                                     if(sectores[k].idsec == sector){
//                                         //if(!sectores[k].acts[ind]){var activity ="None";continue;}
//                                         var activity = sectores[k].acts[ind].nombre;
//                                         d.activity = activity;pa
//                                     }
//                                 }
//                             }
//                             return activity;
//                         } 

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
            'Agropecuario': 'x1', 'Generación Eléctrica': 'x2', 'Industria Petróleo y Gas': 'x3', 'Minería': 'x4', 'Residencial y Comercial': 'x5'
        },
        columns: [
            ['Agropecuario',51208129,13735518,14845796],['x1',1591596,65478,417346594],['Generación Eléctrica',126607656],['x2',204585913],['Industria Petróleo y Gas',80455256,30224652,4213282,8783472,8220642,1833695],['x3',895936597,14216838,1305421,60991145,230284086,46354299],['Minería',9578774],['x4',104079321],['Residencial y Comercial',2503920,628478],['x5',53115667,101486124]
            ],
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
