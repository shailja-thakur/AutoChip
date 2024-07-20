module A (
	input x,
	input y,
	output z
);
	assign z = (x ^ y) & x;
endmodule
module B (
	input x,
	input y,
	output reg z
);
	always @(*) begin
		case ({x, y})
			2'b00: z = 1;
			2'b01: z = 0;
			2'b10: z = 0;
			2'b11: z = 1;
			default: z = 0;
		endcase
	end
endmodule
module top_module (
	input x,
	input y,
	output z
);
	wire zA1, zB1, zA2, zB2;
	wire or_output, and_output;

	// Instantiate the first pair of A and B modules
	A inst_A1 (
		.x(x),
		.y(y),
		.z(zA1)
	);

	B inst_B1 (
		.x(x),
		.y(y),
		.z(zB1)
	);

	// Instantiate the second pair of A and B modules
	A inst_A2 (
		.x(x),
		.y(y),
		.z(zA2)
	);

	B inst_B2 (
		.x(x),
		.y(y),
		.z(zB2)
	);

	// Create OR gate with zA1 and zB1
	assign or_output = zA1 | zB1;

	// Create AND gate with zA2 and zB2
	assign and_output = zA2 & zB2;

	// XOR the outputs of OR and AND gates to get final output
	assign z = or_output ^ and_output;
endmodule
