module xor_ripple 
  (
   input [5:0]  x, y,
   output [5:0] out 
   );
     
   
  // No carry input on first full adder  
 //assign c_out[0] = 6'b000000;
   
  XOR_module XOR_1
    ( 
      .a(x[0]),
      .b(y[0] ),
    
      .out(out[0])
      
      );
 
  XOR_module XOR_2
    ( 
      .a(x[1]),
      .b(y[1] ),
      
      .out(out[1])
     
      );
      
    XOR_module XOR_3
        ( 
          .a(x[2]),
          .b(y[2]),
          
          .out(out[2])
         
          );
   XOR_module XOR_4
            ( 
              .a(x[3]),
              .b(y[3]),
              
              .out(out[3])
             
              );  
 XOR_module XOR_5
                ( 
                .a(x[4]),
                .b(y[4]),
                .out(out[4])
                );  
  XOR_module XOR_6
                  ( 
                  .a(x[5]),
                  .b(y[5]),
                  .out(out[5])
                  );  
            
endmodule 