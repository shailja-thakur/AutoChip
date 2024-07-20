module top_module (
  input clk,
  input w,
  input R,
  input E,
  input L,
  output reg Q
);

  reg D;
  
  always @(posedge clk) begin
    if (E)
      D <= w;
    else if (L)
      D <= R;
    else
      D <= Q;
  end
  
  always @(posedge clk) begin
    if (L)
      Q <= R;
    else
      Q <= D;
  end
  
endmodule
