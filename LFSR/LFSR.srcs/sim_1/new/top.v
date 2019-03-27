`timescale 1ns / 1ps


module top(
   input CCLK,
   input wire reset, 
   output wire max_tick, 
   output [12:0] lfsr_out, 
   output clk
    );
    
    
lfsr LFSR_ (
    .clk(clk),
    .reset(reset),
    .lfsr_out(lfsr_out),
    .max_tick(max_tick)
);

clock M0 (
    .CCLK(CCLK),
    .clkscale(50000000), 
    .clk(clk)
);
endmodule
