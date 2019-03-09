`timescale 1 ns/1 ps

module ALU_testbench;
   // signal declaration
   reg  [5:0] test_in0, test_in1;
   reg [2:0] select; 
   wire [5:0] test_out;

   // instantiate the circuit under test
   ALU_module uut
      (.a(test_in0), .b(test_in1), .out(test_out), .op(select));

   //  test vector generator
    
   initial
   begin
   //TEST 1 
   select = 3'b000; 
   test_in0 = 6'b000101;
   test_in1 = 6'b000101;
   #200
   //TEST 2
   select = 3'b001; 
   test_in0 = 6'b000101;
   test_in1 = 6'b000101;
   #200
   //TEST 3
   select = 3'b010; 
   test_in0 = 6'b000101;
   test_in1 = 6'b000101;
   #200
     //TEST 4
   select = 3'b011; 
   test_in0 = 6'b000101;
   test_in1 = 6'b000101;
   #200
     //TEST 5
   select = 3'b100; 
   test_in0 = 6'b000101;
   test_in1 = 6'b000101;
   #200
     //TEST 6
   select = 3'b101; 
   test_in0 = 6'b000101;
   test_in1 = 6'b000101;
   #200
     //TEST 7
   select = 3'b110; 
   test_in0 = 6'b000101;
   test_in1 = 6'b000101;
   #200
     //TEST 8
   select = 3'b111; 
   test_in0 = 6'b000101;
   test_in1 = 6'b000101;
      $stop;
   end
   endmodule 
