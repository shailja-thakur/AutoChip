module top_module (
   input clk,
   input areset,
   input bump_left,
   input bump_right,
   output walk_left,
   output walk_right
);
   
   parameter WL = 0;
   parameter WR = 1;
   
   reg state;
   
   always @(posedge clk) begin
      if (areset) begin
         state <= WL;
      end else begin
         if (state == WL) begin
            state <= (bump_left) ? WR : WL;
         end else if (state == WR) begin
            state <= (bump_right) ? WL : WR;
         end
      end
   end
   
   assign walk_left = (state == WL) ? 1'b1 : 1'b0;
   assign walk_right = (state == WR) ? 1'b1 : 1'b0;
   
endmodule
