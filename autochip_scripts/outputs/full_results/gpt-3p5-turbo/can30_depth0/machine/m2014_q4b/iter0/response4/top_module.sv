module top_module (
  input clk,
  input d,
  input ar,
  output logic q
);

  always @(posedge clk or posedge ar)
  if (ar == 1'b1)
    q <= 1'b0;
  else if (clk == 1'b1)
    q <= d;
    
endmodule
