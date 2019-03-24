//Thomas Kelly, 16323455 
module stop_watch_test
   (
    input wire clk,
    input wire go, clr,up,
    output wire [3:0] an,
    output wire [7:0] sseg
   );

   // signal declaration
   wire [3:0] d3, d2, d1, d0; // 4 digits 

   // instantiate 7-seg LED display module
   disp_hex_mux disp_unit
      (.clk(clk), .reset(1'b0), .hex3(d3), //add in the minute digit as an input 
        .hex2(d2), .hex1(d1), .hex0(d0),
       .dp_in(4'b0101), .an(an), .sseg(sseg)); //set M.SS.DS format 

   // instantiate stopwatch
   stop_watch_if counter_unit
      (.clk(clk), .go(go), .clr(clr), .up(up), //add in 'up' switch as an input 
       .d3(d3), .d2(d2), .d1(d1), .d0(d0) ); //add minute digit as an output 
       
   //disable the unused display by setting it to 1
    assign an = an | 4'b0000; //activate all digits 

endmodule
