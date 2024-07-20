module top_module (
   input clk,
   input j,
   input k,
   input reset,
   output out
);

   reg state, next_state;

   always @(posedge clk or posedge reset) begin
      if (reset)
         state <= 1'b0;
      else
         state <= next_state;
   end

   always @* begin
      if (state) begin
         if (k)
            next_state = 1'b0;
         else
            next_state = 1'b1;
      end 
      else begin
         if (j)
            next_state = 1'b1;
         else
            next_state = 1'b0;
      end
   end

   assign out = state;

endmodule
