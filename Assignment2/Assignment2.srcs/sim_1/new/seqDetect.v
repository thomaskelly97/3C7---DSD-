`timescale 1ns / 1ps
//11010
module seqDetect(
    input seq_in,
    input clk,reset,
    output reg seq_det
    );
     wire max_tick;   
  
    parameter S0 = 3'b000, S1 = 3'b001,  
    S2 = 3'b010, S3 = 3'b011,
    S4 = 3'b100, S5 = 3'b101; 
    
    reg [2:0] curr, next; 
    
    always @(posedge clk)
    begin 
        if(reset)
            curr <= S0;
        else 
            curr <= next;  
    end
    
    always @(curr, seq_in)
    begin 
        case(curr)
        S0:
        begin 
            if(seq_in == 1)
                next <= S1; 
            else 
                next <= S0; 
        end
        S1: 
        begin 
            if(seq_in == 1)
                next <= S2;
            else
                next <= S1;
        end
        S2: 
        begin
            if(seq_in == 0)
                next <= S3;
            else
                next <= S0;
         end
         S3: 
        begin
            if(seq_in == 1)
                next <= S4;
            else
                next <= S2;
        end
        S4: 
        begin
            if(seq_in == 0)
                next <= S5;
            else
                next <= S2;
        end
        S5: 
        begin 
            if(seq_in == 1)
                next <= S1;
            else 
                next <= S0;
        end
        default: next <= S0; 
        endcase 
    end

    always @(curr)
    begin 
    seq_det <=0; 
    case(curr)
    S0: seq_det <= 0;
    S1: seq_det <= 0;
    S2: seq_det <= 0;
    S3: seq_det <= 0;
    S4: seq_det <= 0;
    S5: seq_det <= 1; 
    default: seq_det <= 0;
    endcase
    end                                            
                              
endmodule
