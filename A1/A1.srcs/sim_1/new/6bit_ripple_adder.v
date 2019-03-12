module ripple_carry_adder_2_FA 
  (
   input [5:0]  x, y,
   input sel,
   output overflow, 
   output [5:0] sum 
  
   );
     wire [5:0] c_out ;
   
  // No carry input on first full adder  
 //assign c_out[0] = 6'b000000;
   
  FullAdder full_adder_1
    ( 
      .a(x[0]),
      .b(y[0] ^ sel),
      .cin(sel),
      .s(sum[0]),
      .cout(c_out[0])
      );
 
  FullAdder full_adder_2
    ( 
      .a(x[1]),
      .b(y[1] ^ sel),
      .cin(c_out[0]),
      .s(sum[1]),
      .cout(c_out[1])
      );
      
    FullAdder full_adder_3
        ( 
          .a(x[2]),
          .b(y[2]^ sel),
          .cin(c_out[1]),
          .s(sum[2]),
          .cout(c_out[2])
          );
   FullAdder full_adder_4
            ( 
              .a(x[3]),
              .b(y[3]^ sel),
              .cin(c_out[2]),
              .s(sum[3]),
              .cout(c_out[3])
              );  
 FullAdder full_adder_5
                ( 
                .a(x[4]),
                .b(y[4]^ sel),
                .cin(c_out[3]),
                .s(sum[4]),
                 .cout(c_out[4])
                );  
  FullAdder full_adder_6
                  ( 
                  .a(x[5]),
                  .b(y[5]^ sel),
                  .cin(c_out[4]),
                  .s(sum[5]),
                  .cout(overflow)
                  );  
              //assign overflow = c_out[5]; 
 
endmodule 