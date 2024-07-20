module top_module(
	input x,
	input y,
	output z);

	// Instantiate module A
	A a1(x, y, z_a1);

	// Instantiate module B
	B b1(x, y, z_b1);

	// Instantiate module A
	A a2(x, y, z_a2);

	// Instantiate module B
	B b2(x, y, z_b2);

	// Define intermediate signals
	wire z_a1, z_b1, z_a2, z_b2;
	wire or_out, and_out;

	// Instantiate OR gate
	OR or_gate(or_out, z_a1, z_b1);

	// Instantiate AND gate
	AND and_gate(and_out, z_a2, z_b2);

	// Instantiate XOR gate
	XOR xor_gate(z, or_out, and_out);

endmodule
module A(
	input x,
	input y,
	output z);

	// Define intermediate signals
	wire x_xor_y;
	wire x_and_x_xor_y;

	// Instantiate XOR gate
	XOR xor_gate(x_xor_y, x, y);

	// Instantiate AND gate
	AND and_gate(x_and_x_xor_y, x, x_xor_y);

	// Assign output
	assign z = x_and_x_xor_y;

endmodule
module B(
	input x,
	input y,
	output z);

	// Define intermediate signals
	wire z;

	// Implement behavior based on simulation waveform
	always @(x or y) begin
		if (x == 0 && y == 0) begin
			z = 1;
		end else if (x == 1 && y == 0) begin
			z = 0;
		end else if (x == 0 && y == 1) begin
			z = 0;
		end else if (x == 1 && y == 1) begin
			z = 1;
		end
	end

endmodule
module OR(
	input a,
	input b,
	output z);
	assign z = a | b;
endmodule
module AND(
	input a,
	input b,
	output z);
	assign z = a & b;
endmodule
module XOR(
	input a,
	input b,
	output z);
	assign z = a ^ b;
endmodule
