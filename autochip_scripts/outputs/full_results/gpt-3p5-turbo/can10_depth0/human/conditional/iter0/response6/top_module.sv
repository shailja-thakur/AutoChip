module top_module (
  input [7:0] a,
  input [7:0] b,
  input [7:0] c,
  input [7:0] d,
  output reg [7:0] min
);

  // Create internal wires to hold intermediate values
  wire [7:0] ab_min;
  wire [7:0] cd_min;

  // Find the minimum of a and b
  assign ab_min = (a < b) ? a : b;

  // Find the minimum of c and d
  assign cd_min = (c < d) ? c : d;

  // Find the overall minimum among ab_min and cd_min
  always @(ab_min, cd_min) begin
    if (ab_min < cd_min)
      min <= ab_min;
    else
      min <= cd_min;
  end

endmodule
