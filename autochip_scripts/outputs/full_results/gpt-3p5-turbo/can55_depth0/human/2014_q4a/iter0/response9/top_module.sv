module top_module (
  input clk,
  input w,
  input R,
  input E,
  input L,
  output reg Q
);

  reg D;
  wire M;
  
  always @(posedge clk) begin
    if (E)
      D <= w;
    else if (L)
      D <= R;
  end
  
  assign M = E ? D : Q;
  
  always @(posedge clk) begin
    if (L)
      Q <= R;
    else
      Q <= M;
  end
  
endmodule
