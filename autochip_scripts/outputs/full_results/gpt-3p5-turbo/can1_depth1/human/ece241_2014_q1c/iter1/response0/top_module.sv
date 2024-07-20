module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output reg overflow  // Use "reg" instead of "wire" for overflow
);

  reg [8:0] sum;  // Include an extra bit to account for overflow

  always @(*)
  begin
    sum = a + b;
    s = sum[7:0];
    overflow = sum[8];
  end

endmodule
