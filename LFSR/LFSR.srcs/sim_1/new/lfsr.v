`timescale 1ns / 1ps

module lfsr(
    input wire clk, reset,
    output wire [12:0] lfsr_out,
    output reg max_tick
    );
    
    reg [12:0] lfsr_reg; 
    reg [12:0] lfsr_next; 
    reg lfsr_tap; 
    
    integer i; 
    localparam seed = 13'b0000000001010;
    always @(posedge clk, posedge reset)
        begin
        if(reset)
            begin
                lfsr_reg <= seed;
                i <= 1'b0; //reset the counter 
                max_tick <= 1'b0; //reset the max tick value 
            end
        else  
            begin
            lfsr_reg <= lfsr_next;
            if (i == ((2**(13))-1)) 
         begin
            max_tick <= 1'b1; 
            i = 0; 
         end
         else 
            max_tick <= 1'b0; 
            end 
            
         
        end
        
    always @(*)
    begin
         i = i + 1; //increment counter
        lfsr_tap = lfsr_reg[0] ^ lfsr_reg[2] ^ lfsr_reg[3] ^ lfsr_reg[12]; 
        lfsr_next = {lfsr_reg[12:0], lfsr_tap};
    end
    
    assign lfsr_out = lfsr_reg; 
    //assign max_tick = (lfsr_reg[12:0] == seed) ? 1'b1 : 1'b0; 
endmodule
