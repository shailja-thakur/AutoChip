module A(
	input x,
	input y,
	output z);

	assign z = (x ^ y) & x;

endmodule
module B(
	input x,
	input y,
	output z);

	// Define B's logic based on the given simulation waveform
	assign z = (x || (~y && (x || y)));

endmodule
module top_module(
	input x,
	input y,
	output z);

	// Define instances of submodule A
	A A1(.x(x), .y(y), .z(z_a1));
	A A2(.x(x), .y(y), .z(z_a2));
	
	// Define instances of submodule B
	B B1(.x(x), .y(y), .z(z_b1));
	B B2(.x(x), .y(y), .z(z_b2));
	
	// Define OR gate
	wire z_or;
	assign z_or = z_a1 || z_b1;
	
	// Define AND gate
	wire z_and;
	assign z_and = z_a2 && z_b2;
	
	// Define XOR gate
	assign z = z_or ^ z_and;

endmodule
