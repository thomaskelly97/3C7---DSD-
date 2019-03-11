// Listing 1.4
//Thomas Kelly, Student Number: 16323455 
//6 BIT GREATER THAN 
module eq2
   (
   //Creation of 6-bit inputs numbers a and b, and a 1 bit output 
    input  wire[5:0] a, b, 	
    output wire [5:0] out		
   );

   //Declaring necessary connections needed. 
   wire e0,e1,e2,e3,e4,e5,e6,e7,e8; //Comprise greater/equal/less connections 
   wire o1,o2,o3; //Hold output possibilities 
            
    //Instantiate 4 2-bit greater than/equal to modules, using 8-bit arrays a,b as inputs 
   eq1 eq_bit0 (.i0(a[0]), .i1(a[1]), .j0(b[0]), .j1(b[1]), .gr(e0), .eq(e1), .ls(e2));
   eq1 eq_bit1 (.i0(a[2]), .i1(a[3]), .j0(b[2]), .j1(b[3]), .gr(e3), .eq(e4), .ls(e5));
   eq1 eq_bit2 (.i0(a[4]), .i1(a[5]), .j0(b[4]), .j1(b[5]), .gr(e6), .eq(e7), .ls(e8));

   
   //Examine each case that could make A bigger than B, or if the two are equal 
   assign o1 = e1 & e3; //the first 2bits of the number A are greater than/equal to B 
   assign o2 = e1 & e4 & e6; //If the first 4 bits are equal, check the 5th and 6th bits A>B
   assign o3 = e1 & e4 & e7; //all equal  
   assign out = e0 |o1 | o2 | o3; //Combine all of these cases under one variable statement
                                        //If any are met output = 1. 'OR' all cases. 
   
   
endmodule
 


