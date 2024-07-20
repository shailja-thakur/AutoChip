module A(
	input x,
	input y,
	output z);

	// Implement the boolean function z = (x^y) & x.
	assign z = (x^y) & x;
endmodule
module B(
	input x,
	input y,
	output z);

	// Implement the simulation waveform for module B.
	always @ (*) begin
		case({x, y})
			2'b00: z = 1;
			2'b01: z = 0;
			2'b10: z = 0;
			2'b11: z = 1;
		endcase
	end
endmodule
module top_module(
	input x,
	input y,
	output z);
	
	// Instantiate two A submodules
	A a1(.x(x), .y(y), .z(a1_z));
	A a2(.x(x), .y(y), .z(a2_z));
	
	// Instantiate two B submodules
	B b1(.x(x), .y(y), .z(b1_z));
	B b2(.x(x), .y(y), .z(b2_z));
	
	// Define intermediate signals
	wire a1_z, a2_z, b1_z, b2_z, or_out, and_out;
	
	// Implement the connections using gates
	assign or_out = a1_z | b1_z;
	assign and_out = a2_z & b2_z;
	assign z = xor(or_out, and_out);
	
endmodule
