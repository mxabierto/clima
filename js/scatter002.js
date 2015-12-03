//DEFAULT

//CATALOGOS

var sectores_ratio = {"idsec":["Agropecuario","Generación Eléctrica","Industria Petróleo y Gas","Minería"],
                   "vals":[
                        [192.79,17.583],[114.351],[25.276,159.258,287.008,32.19,8.564,4.055],[17.916]
                          ]
                }

var sectores_acts = {"idsec":["Agropecuario","Generación Eléctrica","Industria Petróleo y Gas","Minería"],
                   "acts":[
                         ["Fermentación entérica y Manejo del estiercol","Suelos agricolas, quemas agricolas y cultivos de arroz"],
                          ["Generación Eléctrica"],
                          ["Petróleo & Gas","Cemento (combustión y fabricación)","Cal (combustión y fabricación)","Siderúrgica (combustion y proceso)","Química (combustion y proceso)","Consumo de otros carbonatos (Vidrio Metalúrgica)"],
                          ["Minería"]
                          ]
                }
                
var chart = c3.generate({
    bindto: '#chart',
    point: {
        r: function (d) {
            if ( d.value ) {
                var sector = d.id
                var k = d.index
                var j = sectores_ratio.idsec.indexOf(sector);
                var size = sectores_ratio.vals[j][k]
                d.size = size;
                //console.log(size)
                //return gol;
                return size/10;
            }
        }
    },
    data: {
        xs: {
            'Agropecuario': 'x1', 'Generación Eléctrica': 'x2', 'Industria Petróleo y Gas': 'x3', 'Minería': 'x4'
          },
        columns: [
            ['Agropecuario',93821211,19271651],['x1',486651,1096020],['Generación Eléctrica',126607656],['x2',1107180],['Industria Petróleo y Gas',80455256,30224652,4213282,8783472,8849120,1833695],['x3',3183091,189784,14680,272864,1033237,452170],['Minería',9578774],['x4',534644]
           ],
        type: 'scatter'
    },
    axis: {
       x: {
         min: 10,
         tick: {
         fit: false, // adjusts the chart not fit x ticks
         // culling: {
         //            max: 8 // the number of tick texts will be adjusted to less than this value
         //        }
         format: d3.format('.2s'),
            },
        label: { // ADD
          text: 'Valor Agregado Censal Bruto (millones de pesos a precios del 2008)',
          position: 'outer-middle'
        }
      },
      y: {
        tick: {
                format: d3.format('2s')
              },
       // padding: {top: 0, bottom: 0},
        label: { // ADD
          text: 'Emisiones Totales de CO2 (gigatoneladas)',
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
                  var sector = data[i].id;
                  var k = data[i].index;
                  var j = sectores_ratio.idsec.indexOf(sector);
                  var act = sectores_acts.acts[j][k];
    
                }

                value = valueFormat(data[i].value, data[i].ratio, data[i].id, data[i].index);
                text += "<span class='info'> Actividad económica: " + act + "</span><br>";
                text += "<span class='info'> Valor Agregado: "+ title + " millones  de pesos</span><br>";
                text += "<span class='info'> Emisiones: " + value + " CO2/Kg </span><br>";
                text += "<span class='info'> Razón de Eficiencia: "+ size + " GTon CO2 / Millones Pesos </span>";
                text += "</div>";
            }
        return text;
        }
    }
});
