/*d3 = require("d3");
crossfilter = require("crossfilter");
module.exports = require("./dc");*/

var chart = c3.generate({
    data: {
        columns: [
            ['Lulu', 50],
            ['Olaf', 50],
        ],
        type : 'donut'
    },
    donut: {
        title: "Dogs love:",
    }
});


// document.addEventListener("DOMContentLoaded", function(event) { 
//   //do work
// });