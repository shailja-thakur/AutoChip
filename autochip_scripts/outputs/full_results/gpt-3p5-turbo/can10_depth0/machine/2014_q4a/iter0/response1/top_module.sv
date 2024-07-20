module top_module (
   input clk,
   input w,
   input R,
   input E,
   input L,
   output reg Q
);

always @(posedge clk) begin
   if (E == 1'b0) begin
      Q <= Q; // hold Q in its current state
   end else begin
      if (L == 1'b1) begin
         Q <= R; // update Q with the value of R
      end else begin
         Q <= w; // update Q with the value of w
      end
   end
end

endmodule
