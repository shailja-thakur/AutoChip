module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	// Declare internal signals
	wire [7:0] sum;
	reg overflow;

	// Adder module instantiation
	adder_module adder(
		.a(a),
		.b(b),
		.s(sum),
		.overflow(overflow)
	);

	// Assign output signals
	assign s = sum;

endmodule
module adder_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
	reg [8:0] temp;

	// Adder logic
	always @* begin
		temp = a + b;	// Perform addition
		if (temp[8] == 1'b1)	// Check for overflow
			overflow = 1'b1;
		else
			overflow = 1'b0;
	end

	// Output assignment
	assign s = temp[7:0];

endmodule
