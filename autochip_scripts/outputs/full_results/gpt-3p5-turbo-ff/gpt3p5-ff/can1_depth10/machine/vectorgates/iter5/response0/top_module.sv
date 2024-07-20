module top_module(
  input [2:0] a,
  input [2:0] b,
  output [2:0] out_or_bitwise,
  output reg out_or_logical,
  output reg [7:0] out_not
);

  // Bitwise OR operation
  assign out_or_bitwise = a | b;

  // Logical OR operation
  always @* begin
    out_or_logical = (a != 0) | (b != 0);
  end

  // Bitwise NOT operation
  always @* begin
    out_not = ~{2'b0, a, b};
  end

endmodule
