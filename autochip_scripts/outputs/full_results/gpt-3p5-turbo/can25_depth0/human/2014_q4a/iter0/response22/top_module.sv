module top_module (
  input clk,
  input w,
  input R,
  input E,
  input L,
  output reg Q
);

  wire D;

  always @(posedge clk) begin
    if (E)
      D <= w;
    else if (L)
      D <= R;
  end

  always @(posedge clk) begin
    if (L)
      Q <= D;
  end

endmodule
