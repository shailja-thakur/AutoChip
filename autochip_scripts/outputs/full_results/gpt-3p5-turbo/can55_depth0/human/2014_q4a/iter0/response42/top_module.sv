module top_module (
  input clk,
  input w,
  input R,
  input E,
  input L,
  output reg Q
);

  reg D;
  reg T;

  always @(posedge clk) begin
    if (L)
      D <= R;
    else
      D <= T;
    if (E)
      T <= w;
    else
      T <= D;
    Q <= T;
  end

endmodule
