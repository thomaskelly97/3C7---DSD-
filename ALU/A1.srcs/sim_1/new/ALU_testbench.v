`timescale 1 ns/1 ps

module ALU_testbench;
   //declare signals 
   reg  [5:0] test_in0, test_in1; //inputs a,b 
   reg [2:0] select; //operation code 
   wire [5:0] test_out; //output 
   wire overflow; 

   // instantiate the circuit under test
   ALU_module uut 
      (.a(test_in0), .b(test_in1), .op(select), .out(test_out), .overflow(overflow));

   
   //Initialise all inputs 
   initial
   begin
    test_in0 = 0; 
    test_in1 = 0; 
    select = 0;  
   end 
   
   //ASSIGN DIFFERENT TEST VECTORS. 1 for each operation! 
   always @(test_in0 or test_in1)
   begin 
   //TEST 1 
   test_in0 = 6'b001011;
   test_in1 = 6'b010001;
   select = 3'b000; 
   #200;
    //TEST 2 
   test_in0 = 6'b010011;
   test_in1 = 6'b011001;
   select = 3'b001; 
   #200;
   //TEST 3
   test_in0 = 6'b000111;
   test_in1 = 6'b001001;
   select = 3'b010; 
   #200;
   //TEST 4
   test_in0 = 6'b001011;
   test_in1 = 6'b010001;
   select = 3'b011; 
   #200;
   //TEST 5 
   test_in0 = 6'b001111;
   test_in1 = 6'b000001;
   select = 3'b100; 
   #200;
   //TEST 6
   test_in0 = 6'b011011;
   test_in1 = 6'b000101;
   select = 3'b101; 
   #200;
   //TEST 7 
   test_in0 = 6'b000111;
   test_in1 = 6'b001001;
   select = 3'b110; 
   #200;
   //TEST 8 
   test_in0 = 6'b000011;
   test_in1 = 6'b010001;
   select = 3'b111; 
   #200;
   end
endmodule 
