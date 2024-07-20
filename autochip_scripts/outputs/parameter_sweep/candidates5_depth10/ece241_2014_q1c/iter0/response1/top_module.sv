module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	reg [7:0] s_temp;
	wire [8:0] sum;

	assign sum = a + b;
	assign s_temp = sum[7:0];
	assign s = s_temp[7:0];
	assign overflow = sum[8];

endmodule
