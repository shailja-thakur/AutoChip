module top_module (
  input clk,
  input w,
  input R,
  input E,
  input L,
  output reg Q
);

always @(posedge clk) begin
  if (E == 1'b0)
    Q <= Q; // Hold current state
  else if (L == 1'b1)
    Q <= R; // Update with value of R
  else
    Q <= w; // Update with value of w
end

endmodule
