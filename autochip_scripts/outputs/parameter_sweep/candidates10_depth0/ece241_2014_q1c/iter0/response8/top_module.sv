module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

// Internal signals
wire [8:0] sum;

// Adder module instance
add8 adder_inst(
	.a(a),
	.b(b),
	.s(sum)
);

// Output assignment for s
assign s = sum[7:0];

// Output assignment for overflow
assign overflow = sum[8];

// Adder module definition
module add8 (
	input [7:0] a,
	input [7:0] b,
	output [8:0] s
);
	assign s = a + b;
endmodule
