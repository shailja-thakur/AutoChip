module top_module(
  input a,
  input b,
  input c,
  output reg out
);

  always @(a, b, c)
  begin
    out = a | b | c;
  end

endmodule
