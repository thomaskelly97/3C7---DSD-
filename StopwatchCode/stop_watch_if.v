//Thomas Kelly, 16323455 
module stop_watch_if
   (
    input wire clk,
    input wire go, clr,up, //added input 'up' switch. 
    output wire [3:0] d3, d2, d1, d0 // added minute digit, 4 digits  
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
   assign ms_next = (clr || (ms_reg==DVSR && go)) ? 4'b0 : // if(clr == high OR ms_reg == DVSR AND go == true) -then-> ms_next = 0; 
                    (go) ? ms_reg + 1 : //else if go == high -> ms_reg++ 
                           ms_reg; //else next = ms_reg 
   assign ms_tick = (ms_reg==DVSR) ? 1'b1 : 1'b0; //if(ms_reg == DVSR) -> ms_tick = 1; otherwise ms_tick = 0; 
   // 3-digit bcd counter
   always @*
   begin
      // default: keep the previous value
      d0_next = d0_reg;
      d1_next = d1_reg;
      d2_next = d2_reg;
      d3_next = d3_reg; //added for minute digit 
      if (clr) //if clr is high 
         begin //reset all to zero if clr is pressed 
            d0_next = 4'b0;
            d1_next = 4'b0;
            d2_next = 4'b0;
            d3_next = 4'b0; 
            //d0 = 1'b0; 
            //d1 = 1'b0; 
            //d2 = 1'b0; 
            //d3 = 1'b0; 
         end
       //INCREMENT
       else if (up) //if switch is selected to increment up==high
        begin //1
          if (ms_tick) //sample 
             if (d0_reg != 9) //if d0_reg != 9 
                d0_next = d0_reg + 1; //increment next 
             else              // reach XX9
                begin//2
                   d0_next = 4'b0;
                   if (d1_reg != 9)
                      d1_next = d1_reg + 1;
                   else       // reach X99
                      begin//3
                         d1_next = 4'b0;
                         if (d2_reg != 5)
                            d2_next = d2_reg + 1;
                         else // reach 59.9
                            begin //4
                                d2_next = 4'b0;//set seconds back to zero - loop back around 
                                if(d3_reg != 9) 
                                    d3_next = d3_reg + 1; //increment minute digit 
                                else 
                                    d3_next = 4'b0; //reset to 0.00.0, i.e. reach 9.59.9
                            end //4
                      end//3
                end//2
             end//1
                //DECREMENT
           else //'up' switch is set to LOW, so when 'go' button is pressed stopwatch will decrement 
            begin //1
            if(ms_tick)
              if (d0_reg != 0) //if d0_reg != 0
                d0_next = d0_reg - 1; //decrement next 
             else              // reach XX.0
                begin //2 
                   d0_next = 4'b1001; //set XX.9
                   if (d1_reg != 0)
                      d1_next = d1_reg - 1;
                   else       // reach X0.0
                      begin //3
                         d1_next = 4'b1001;//set X9.9 
                         if (d2_reg != 0)
                            d2_next = d2_reg - 1;
                         else // reach X.09.9
                            begin //4
                                d2_next = 4'b0101;//set 59.9 
                                if(d3_reg != 0) //reach 
                                    d3_next = d3_reg - 1; //increment minute digit 
                                else 
                                    d3_next = 4'b1001; //reset to 9.59.9 if we decrement below zero, wrap around 
                            end //4
                      end //3
                end //2
            end //1
      end //end always statement 
   // output logic
   assign d0 = d0_reg;
   assign d1 = d1_reg;
   assign d2 = d2_reg;
   assign d3 = d3_reg; //assign the output digits 

endmodule