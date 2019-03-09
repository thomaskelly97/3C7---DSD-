`timescale 1ns / 1ps

module ALU_module(
    input [5:0] a,b, 
    input [2:0] op, 
    output [5:0] out,
    output cout
    );

reg [5:0] result; 

 assign out = result; 
//ADD
ripple_carry_adder_2_FA adder1(
            .x(a), .y(b),  .sel(1'b0), .overflow(cout),.sum(out)
        );
assign add_out = out; 

//SUBTRACT
ripple_carry_adder_2_FA subber2(
.x(a), .y(b),  .sel(1'b1), .overflow(cout),.sum(out)
);
assign sub_out = out; 

always @(*)
begin 
    case(op)
    3'b000:
         result = a; 
    3'b001: 
         result = b; 
    3'b010:
         result = -a; 
    3'b011: 
         result = -b; 
   // 3'b100:
     //    result = eq(.x(a), .y(b), .out(out)); 
    //3'b101: 
      //   result = xor_ripple(.x(a), .y(b), .out(out)); 
    3'b110: 
         result = add_out; 
    3'b111: 
         result = sub_out; 
    default: result = a; 
    endcase 
   
end 

endmodule 