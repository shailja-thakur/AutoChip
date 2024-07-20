module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

	wire [3:0] c; // Carry signals between full adders

	// Full adder for bit 0
	assign {c[0], sum[0]} = x[0] + y[0] + 1'b0;

	// Full adder for bit 1
	assign {c[1], sum[1]} = x[1] + y[1] + c[0];

	// Full adder for bit 2
	assign {c[2], sum[2]} = x[2] + y[2] + c[1];

	// Full adder for bit 3
	assign {c[3], sum[3]} = x[3] + y[3] + c[2];

	// Overflow bit
	assign sum[4] = c[3];

endmodule
