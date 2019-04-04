`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module seqTestbench();

reg seq_in;
reg clk, reset; 
wire seq_count; 

seqDetect uut (
    .seq_in (seq_in),
    .clk(clk),
    .reset(reset),
    .seq_count(seq_count)
);

    initial 
        begin 
        clk =0; 
        forever #5 clk = ~clk; 
    end 
    
    initial 
    begin 
    reset = 1'b1;
    #15
    reset = 1'b0;  
    
        
    end
       
endmodule
