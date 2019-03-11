`timescale 1ns / 1ps

//This module ASSIGNS the FINAL result. 
module conn(
    input [5:0] a,b, //define inputs a and b as we need them for the first four operations. (a,b,-a,-b)
    input [2:0] sel, //operation selector 
    input [5:0] add_res, //store add result
    input [5:0] sub_res, //store subtraction result
    input [5:0] xor_res,//store xor result
    input [5:0] gte_res, //store greater than/equal to result
    output reg [5:0] final   //stores the FINAL ouput 
    );
    reg [2:0] code; //operation code copy, type reg because we need to utilise its value  
        
    always @(*) begin //Define an always block to procedurally cycle through operations 1->8 
        assign code = sel;
        case(code[2:0]) //assign the value of final based on the incoming operation code. 
            3'b000: assign final = a;
            3'b001: assign final = b;
            3'b010: assign final = -a;
            3'b011: assign final = -b;
            3'b100: assign final = { {6{gte_res[5]}}, gte_res };
            3'b101: assign final = { {6{xor_res[5]}}, xor_res };
            3'b110: assign final = { {6{add_res[5]}}, add_res };
            3'b111: assign final = { {6{sub_res[5]}}, sub_res };
            
         endcase 
    end 
endmodule
