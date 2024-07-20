module top_module (
	input clk,
	input in,
	input areset,
	output out
);

   // Declare state type and current state variable
   typedef enum logic [1:0] {
      A,
      B,
      C,
      D
   } state_type;
   
   state_type current_state;
   
   always_ff @(posedge clk or posedge areset) begin
      if (areset) begin
         // Asynchronous reset, reset to state A
         current_state <= A;
      end else begin
         // State transitions based on current input and current state
         case (current_state)
            A: if (in) current_state <= B; else current_state <= A;
            B: if (in) current_state <= B; else current_state <= C;
            C: if (in) current_state <= D; else current_state <= A;
            D: if (in) current_state <= B; else current_state <= C;
         endcase
      end
   end
   
   // Define the output based on the current state
   always_comb begin
      case (current_state)
         A, B, C: out = 0;
         D: out = 1;
      endcase
   end

endmodule
