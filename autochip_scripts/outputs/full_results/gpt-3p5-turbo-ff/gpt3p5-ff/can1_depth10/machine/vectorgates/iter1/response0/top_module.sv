module top_module(
  input [2:0] a,
  input [2:0] b,
  output reg [2:0] out_or_bitwise,
  output reg out_or_logical,
  output reg [5:0] out_not
);

  // Bitwise OR operation
  always @* begin
    out_or_bitwise = a | b;
  end

  // Logical OR operation
  always @* begin
    out_or_logical = a | b;
  end

  // Bitwise NOT operation
  always @* begin
    out_not = ~{{3'b0, a}} & ~{{3'b0, b}};
  end

endmodule
