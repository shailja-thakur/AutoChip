module top_module (
  input [3:0] a,
  input [3:0] b,
  input [3:0] c,
  input [3:0] d,
  input [3:0] e,
  output reg [3:0] q
);

  always @* begin
    case ({a, b, c, d, e})
      5'b00_00_0: q <= b; // 0
      5'b00_00_1: q <= e; // 1
      5'b00_01_0: q <= a; // 2
      5'b00_01_1: q <= d; // 3
      5'b00_10_0: q <= f; // 4
      5'b00_10_1: q <= f; // 5
      5'b00_11_0: q <= f; // 6
      5'b00_11_1: q <= f; // 7
      5'b01_00_0: q <= f; // 8
      5'b01_00_1: q <= f; // 9
      5'b01_01_0: q <= f; // a
      5'b01_01_1: q <= f; // b
      5'b01_10_0: q <= f; // c
      5'b01_10_1: q <= f; // d
      5'b01_11_0: q <= f; // e
      5'b01_11_1: q <= f; // f
      default: q <= 4'b0; // default value
    endcase
  end

endmodule
