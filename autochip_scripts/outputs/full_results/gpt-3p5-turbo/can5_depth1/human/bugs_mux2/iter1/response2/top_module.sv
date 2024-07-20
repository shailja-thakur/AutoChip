module top_module (
  input sel,
  input [7:0] a,
  input [7:0] b,
  output reg [7:0] out
);

  always @(sel, a, b)
    if (sel)
      out <= b; // use non-blocking assignment
    else
      out <= a; // use non-blocking assignment

endmodule
