module top_module(
  input clk,
  input L,
  input q_in,
  input r_in,
  output reg Q);

  always @(posedge clk) begin
    if (L)
      Q <= r_in;
    else
      Q <= q_in;
  end

endmodule
