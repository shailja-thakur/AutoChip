module top_module (
	input [3:0] x,
	input [3:0] y,
	output reg [4:0] sum
);

	// Declare internal signals
	wire [3:0] c;

	// Instantiate full adders
	full_adder FA0 (
		.x(x[0]),
		.y(y[0]),
		.cin(1'b0),
		.sum(sum[0]),
		.c(c[0])
	);
	full_adder FA1 (
		.x(x[1]),
		.y(y[1]),
		.cin(c[0]),
		.sum(sum[1]),
		.c(c[1])
	);
	full_adder FA2 (
		.x(x[2]),
		.y(y[2]),
		.cin(c[1]),
		.sum(sum[2]),
		.c(c[2])
	);
	full_adder FA3 (
		.x(x[3]),
		.y(y[3]),
		.cin(c[2]),
		.sum(sum[3]),
		.c(sum[4])
	);
	
endmodule
module full_adder (
	input x,
	input y,
	input cin,
	output reg sum,
	output reg c
);

	always @(x, y, cin)
	begin
		sum = x ^ y ^ cin;
		c = (x & y) | (cin & (x ^ y));
	end

endmodule
