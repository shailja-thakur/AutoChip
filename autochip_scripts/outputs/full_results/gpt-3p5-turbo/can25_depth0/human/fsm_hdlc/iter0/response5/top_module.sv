module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

   // Define state enumeration
   typedef enum logic [2:0] {
      START,
      WAIT_FLAG,
      WAIT_DISC,
      CHECK_ERR
   } state_e;
   
   // Define state variable and flip flop
   state_e state, next_state;
   logic flag_ff, err_ff;
   
   always_ff @(posedge clk or posedge reset) begin
      if (reset) begin
         // Reset state and flip flops
         state <= START;
         flag_ff <= 0;
         err_ff <= 0;
      end
      else begin
         // Assign next state based on current state and input
         case (state)
            START:
               if (in)
                  next_state <= WAIT_FLAG;
               else
                  next_state <= START;
               
            WAIT_FLAG:
               if (in)
                  next_state <= WAIT_FLAG;
               else
                  next_state <= WAIT_DISC;
               
            WAIT_DISC:
               if (in)
                  if (err_ff)
                     next_state <= CHECK_ERR;
                  else
                     next_state <= WAIT_DISC;
               else
                  next_state <= WAIT_FLAG;
               
            CHECK_ERR:
               if (in)
                  next_state <= CHECK_ERR;
               else
                  if (flag_ff)
                     next_state <= WAIT_FLAG;
                  else
                     next_state <= START;
         endcase
         
         // Update state and flip flops
         state <= next_state;
         flag_ff <= (state == WAIT_FLAG);
         err_ff <= (state == CHECK_ERR);
      end
   end
   
   // Assign output signals based on state
   assign disc = (state == WAIT_DISC);
   assign flag = (state == WAIT_FLAG);
   assign err = (state == CHECK_ERR);
   
endmodule
