module top_module (
   input clk,
   input in,
   input reset,
   output reg out
);

   reg state;

   always @(posedge clk) begin
      if (reset)
         state <= 1'b0;  // initial state is B
      else begin
         if (state == 1'b0) begin
            if (in)
               state <= 1'b0;  // next state is B if in is high
            else
               state <= 1'b1;  // next state is A if in is low
         end else begin
            if (in)
               state <= 1'b1;  // next state is A if in is high
            else
               state <= 1'b0;  // next state is B if in is low
         end
      end
   end

   assign out = state;  // out is high if state is B, otherwise low

endmodule
