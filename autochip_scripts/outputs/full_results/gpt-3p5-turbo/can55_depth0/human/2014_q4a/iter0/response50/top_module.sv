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
    if (L)
      D <= R;
    else if (E)
      D <= Q;
    else
      D <= w;
  end
  
  always @(posedge clk)
    if (L)
      Q <= D;
  
endmodule
