module top_module (
  input [3:0] a, 
  input [3:0] b, 
  input [3:0] c, 
  input [3:0] d,
  input [3:0] e,
  output reg [3:0] q
);

  always @* begin
    case({a, b, c, d, e})
      16'b00000: q <= b;
      16'b10000: q <= e;
      16'b10010: q <= a;
      16'b10011: q <= d;
      16'b10100: q <= f;
      16'b10101: q <= f;
      16'b10110: q <= f;
      16'b10111: q <= f;
      16'b11000: q <= f;
      16'b11001: q <= f;
      16'b11010: q <= f;
      16'b11011: q <= f;
      16'b11100: q <= f;
      16'b11101: q <= f;
      16'b11110: q <= f;
      16'b11111: q <= f;
    endcase
  end

endmodule
