//Thomas Kelly, 16323455 
module stop_watch_if
   (
    input wire clk,
    input wire go, clr,
    output wire [3:0] d3, d2, d1, d0 // 4 digits  
   );

   // declaration
   localparam  DVSR = 10000000;
   reg [23:0] ms_reg;
   wire [23:0] ms_next;
   reg [3:0] d3_reg, d2_reg, d1_reg, d0_reg;//added reg's for minute digit 
   reg [3:0] d3_next, d2_next, d1_next, d0_next;
   wire ms_tick;

   // body
   // register
   always @(posedge clk)
   begin
      ms_reg <= ms_next; //move _reg to next value 
      d3_reg <= d3_next; //(minute digit)
      d2_reg <= d2_next;
      d1_reg <= d1_next;
      d0_reg <= d0_next;
   end

   // next-state logic
   // 0.1 sec tick generator: mod-5000000
   assign ms_next = (clr || (ms_reg==DVSR && go)) ? 4'b0 : //if clr == high OR ms_reg == high AND go == high -> next = 1 
                    (go) ? ms_reg + 1 : //else if go == high -> ms_reg++ 
                           ms_reg; //else next = ms_reg 
   assign ms_tick = (ms_reg==DVSR) ? 1'b1 : 1'b0;
   // 3-digit bcd counter
   always @*
   begin
      // default: keep the previous value
      d0_next = d0_reg;
      d1_next = d1_reg;
      d2_next = d2_reg;
      d3_next = d3_reg; //added for minute digit 
      if (clr) //if clr is high 
         begin
            d0_next = 4'b0;
            d1_next = 4'b0;
            d2_next = 4'b0;
            d3_next = 4'b0; //reset all to zero if clr is pressed 
         end
      else if (ms_tick) //ms_tick == high 
         if (d0_reg != 9) //if d0_reg != 9 
            d0_next = d0_reg + 1; //increment next 
         else              // reach XX9
            begin
               d0_next = 4'b0;
               if (d1_reg != 9)
                  d1_next = d1_reg + 1;
               else       // reach X99
                  begin
                     d1_next = 4'b0;
                     if (d2_reg != 5)
                        d2_next = d2_reg + 1;
                     else // reach 599
                        begin 
                            d2_next = 4'b0;//set seconds back to zero 
                            if(d3_reg != 9) //reach 
                                d3_next = d3_reg + 1; //increment minute digit 
                            else 
                                d3_next = 4'b0; //reset to 0.00.0
                        end 
                  end
            end
   end
   // output logic
   assign d0 = d0_reg;
   assign d1 = d1_reg;
   assign d2 = d2_reg;
   assign d3 = d3_reg; //assign the output digits 

endmodule