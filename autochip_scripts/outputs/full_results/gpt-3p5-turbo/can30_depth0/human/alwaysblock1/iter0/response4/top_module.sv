module top_module(
  input a,
  input b,
  output out_assign,
  output reg out_alwaysblock
);

  // Use assign statement to implement AND gate
  assign out_assign = a & b;

  // Use combinational always block to implement AND gate
  always @* begin
    out_alwaysblock = a & b;
  end

endmodule
