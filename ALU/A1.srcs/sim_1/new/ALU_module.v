`timescale 1ns / 1ps

module ALU_module( //create ALU module 
    input [5:0] a,b, //two inputs 
    input [2:0] op, //operation selector, 3-bit code 
    output [5:0] out, //6-bit output result 
    output overflow //overflow 
   // output cout
    );

wire [5:0] add_res, sub_res, xor_res, gte_res; //store results from respective operation. 

//INSTANTIATIONS FOR...
 
//ADDER
ripple_carry_adder_2_FA adder1(
            .x(a), .y(b),  .sel(1'b0), .overflow(overflow),.sum(add_res)
        );

//SUBTRACTER
ripple_carry_adder_2_FA subber2(
.x(a), .y(b),  .sel(1'b1), .overflow(overflow),.sum(sub_res) //This is the adder however notice 'sel'(select) bit is set to 1 to signify subtraction.
);

//XOR 
xor_ripple xor1(
       .x(a), .y(b), .out(xor_res) //2 6bit inputs, one 6bit output 
);

//GREATER THAN/EQUAL TO
eq2 ge1 (
    .a(a), .b(b), .out(gte_res) //2 6bit inputs, one 6bit output 
);

conn C( //the purpose of this module is to read operation code and assign the FINAL result to be output
    .a(a), .b(b), .sel(op), .add_res(add_res), .sub_res(sub_res), .xor_res(xor_res), .gte_res(gte_res), .final(out)
);
endmodule 