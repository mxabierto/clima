//DEFAULT
var datajson = []
for (var i = 0; i < 100; i++){
    datajson.push({
        total: Math.ceil(Math.random() * 10)
    });
}


//var catalogo = JSON.parse('{{"id": "MICROSOFT","acts":{"indicador":1,nombre:"Games","indicador":2,nombre:"Joysticks"}}, {"id": "IBM","acts":{"indicador":1,nombre:"Computers","indicador":2,nombre:"Laptops"}}}')

// getact = function (d) {     var sector = d.id;
//                             var ind = d.index;
//                             var sectores = [{"idsec": "Microsoft","acts":[{"indicador":1,"nombre":"Games"},{"indicador":2,"nombre":"Joysticks"}]},
//                                             {"idsec": "IBM","acts":[{"indicador":1,"nombre":"Computers"},{"indicador":2,"nombre":"Laptops"}]}
//                                             ];
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
            ['Agropecuario',15.1506265473043,4.06384118528868],['x1',0.0928579000403256,0.00382015887124649] ['Generación Eléctrica',37.4586096298415],['x2',11.9360806756317] ['Industria Petróleo y Gas',23.8037897737635,8.94237739039896,1.24655720423762,2.5987105301329,2.43218956351802,0.542523788491845],['x3',52.2712993540418,0.829447750492903,0.0761616972702506,3.558383940243,13.4353797312042,2.70443181748469] ['Minería',2.83401152295621],['x4',6.07226154481599] ['Residencial y Comercial',0.740819037233837,0.185943826832586],['x5',3.09890782388321,5.92096760602068]],
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
