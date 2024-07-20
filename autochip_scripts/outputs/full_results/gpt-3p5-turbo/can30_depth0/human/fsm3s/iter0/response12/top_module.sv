module top_module ( input clk, input in, input reset, output out ); 

   // Define states
   typedef enum logic [1:0] {A, B, C, D} state_type;
   state_type current_state, next_state;
   
   // Define outputs
   logic output;
   
   // Define state transition table
   always_ff @(posedge clk, posedge reset)
   begin
      if (reset)
         current_state <= A;
      else
         current_state <= next_state;
   end
   
   always_comb
   begin
   	// Reset default values
   	output = 0;
   	
      case (current_state)
         A: begin
            if (in)
               next_state = B;
            else
               next_state = A;
         end
         B: begin
            if (in)
               next_state = B;
            else
               next_state = C;
         end
         C: begin
            if (in)
               next_state = D;
            else
               next_state = A;
         end
         D: begin
            if (in)
               next_state = B;
            else
               next_state = C;
         end
         default: next_state = A;
      endcase
   end
   
   always_comb
   begin
      case (current_state)
         D: output = 1;
         default: output = 0;
      endcase
   end
   
   assign out = output;

endmodule
