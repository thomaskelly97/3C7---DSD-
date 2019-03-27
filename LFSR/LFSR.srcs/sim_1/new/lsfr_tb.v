`timescale 1 ns/1 ps

module lsfr_tb(); 

reg clk, reset; 
wire [12:0] lfsr_out;
wire max_tick; 


lfsr uut 
    (
        .clk(clk), .reset(reset), .lfsr_out(lfsr_out),.max_tick(max_tick)
    );
    
 initial 
    begin 
        clk = 1'b0; 
        forever #10 clk = !clk;
    end
   initial 
    begin  
        reset = 1'b1; 
        #200
        reset = 1'b0; 
    end 
    
endmodule 