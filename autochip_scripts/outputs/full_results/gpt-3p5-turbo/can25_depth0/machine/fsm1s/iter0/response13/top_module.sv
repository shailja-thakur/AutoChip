module top_module (
   input clk,
   input in,
   input reset,
   output reg out
);

   reg state;

   always @(posedge clk) begin
      if (reset)
         state <= 1'b0; // Reset to initial state B
      else if (state) begin // If current state is B
         if (in)
            state <= 1'b0; // Transition to state A if in input is high
      end
      else begin  // If current state is A
         if (~in)
            state <= 1'b1; // Transition to state B if in input is low
      end
   end

   assign out = state;

endmodule
