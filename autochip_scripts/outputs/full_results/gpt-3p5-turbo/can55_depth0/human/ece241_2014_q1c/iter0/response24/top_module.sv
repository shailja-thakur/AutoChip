module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

  // Internal signals
  wire [8:0] sum;

  // Generate sum
  assign sum = a + b;

  // Calculate overflow
  assign overflow = (sum[8] != sum[7]);

  // Assign sum[7:0] to s[7:0]
  assign s = sum[7:0];

endmodule
