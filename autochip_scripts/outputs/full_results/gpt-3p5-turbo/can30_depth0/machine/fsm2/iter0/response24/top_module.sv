module top_module (
   input clk,
   input j,
   input k,
   input areset,
   output reg out
);

   // Define the states
   typedef enum logic [1:0] {
      A,
      B
   } state_type;
   
   // Define variables for current state and next state
   reg state_type current_state, next_state;
   
   // Combinational always block to determine next state based on current state and input values
   always_comb begin
      case(current_state)
         A: begin
            if (j)
               next_state = B;
            else
               next_state = A;
         end
         B: begin
            if (k)
               next_state = A;
            else
               next_state = B;
         end
      endcase
   end
   
   // Clock always block to update the state based on the areset and next state values
   always_ff @(posedge clk, posedge areset) begin
      if (areset) begin
         current_state <= A;
      end
      else begin
         current_state <= next_state;
      end
   end
 
   // Assign the out port based on the current state
   assign out = (current_state == B) ? 1'b1 : 1'b0;
   
endmodule
