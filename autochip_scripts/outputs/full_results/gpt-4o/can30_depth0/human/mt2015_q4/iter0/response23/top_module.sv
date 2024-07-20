module top_module(
	input x,
	input y,
	output z);

	wire a1_out, a2_out, b1_out, b2_out;
	wire or_out, and_out;

	// Module A instantiation
	a_module a1 (
		.x(x),
		.y(y),
		.z(a1_out)
	);

	// Module A instantiation
	a_module a2 (
		.x(x),
		.y(y),
		.z(a2_out)
	);

	// Module B instantiation
	b_module b1 (
		.x(x),
		.y(y),
		.z(b1_out)
	);

	// Module B instantiation
	b_module b2 (
		.x(x),
		.y(y),
		.z(b2_out)
	);

	// OR gate
	assign or_out = a1_out | b1_out;

	// AND gate
	assign and_out = a2_out & b2_out;

	// XOR gate
	assign z = or_out ^ and_out;

endmodule
module a_module(
	input x,
	input y,
	output z);

	assign z = (x ^ y) & x;

endmodule
module b_module(
	input x,
	input y,
	output reg z);

	always @(*) begin
		case({x, y})
			2'b00: z = 1;
			2'b01: z = 0;
			2'b10: z = 0;
			2'b11: z = 1;
			default: z = 0;
		endcase
	end
endmodule
