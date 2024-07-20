module top_module(
  input clk,
  input L,
  input q_in,
  input r_in,
  output reg Q
);

always @(posedge clk) begin
  if (L == 1'b0) Q <= q_in;
  else Q <= r_in;
end

endmodule
