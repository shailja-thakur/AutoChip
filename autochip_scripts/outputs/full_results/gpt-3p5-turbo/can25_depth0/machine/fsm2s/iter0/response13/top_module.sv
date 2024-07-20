module top_module (
   input clk,
   input j,
   input k,
   input reset,
   output reg out
);

   reg state, next_state;

   always @(posedge clk) begin
      if (reset) begin
         state <= 1'b0; // Set initial state to A
      end else begin
         state <= next_state; // Transition to next state
      end
   end

   always @* begin
      if (state) begin // State B
         out = 1'b1;
         if (k) begin
            next_state = 1'b0; // Transition to state A
         end else begin
            next_state = state; // Remain in state B
         end
      end else begin // State A
         out = 1'b0;
         if (j) begin
            next_state = 1'b1; // Transition to state B
         end else begin
            next_state = state; // Remain in state A
         end
      end
   end

endmodule
