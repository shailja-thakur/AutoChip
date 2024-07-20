module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);
  reg out_reg;
  
  always @(a, b, c, d) begin
    if ((c == 0 && b == 0) || (d == 0 && a == 0) || (a && c && d) || (b && c && d))
      out_reg = 1;
    else
      out_reg = 0;
  end
  
  assign out = out_reg;
endmodule
