`timescale 1ns / 1ps

module top_testbench( );

    parameter T = 20; 
    reg clk, reset;
    wire max_tick;
    wire [12:0] lfsr_out;
    
   // Instantiate the LFSR module
    top uut(
    .CCLK (clk),
    .reset(reset),
    .max_tick(max_tick),
    .lfsr_out(lfsr_out)
    );
    
    
    always
    begin
        clk = 1'b1; 
        #(T/2)  
        clk = 1'b0; 
        #(T/2); 
    end
   
initial
    begin
        reset = 1'b1;
        #(2*T); 
        reset = 1'b0;
    end
endmodule