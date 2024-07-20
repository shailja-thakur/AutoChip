module A(
	input x,
	input y,
	output z);
	
	// Implement the boolean function z = (x^y) & x
	assign z = (x ^ y) & x;
	
endmodule
module B(
	input x,
	input y,
	output z);
	
	// Module B waveform:
	// time        x      y      z
	// 0ns         0      0      1
	// 5ns         0      0      1
	// 10ns        0      0      1
	// 15ns        0      0      1
	// 20ns        0      0      1
	// 25ns        1      0      0
	// 30ns        1      0      0
	// 35ns        0      1      0
	// 40ns        0      1      0
	// 45ns        1      1      1
	// 50ns        1      1      1
	// 55ns        0      0      1
	// 60ns        0      1      0
	// 65ns        0      1      0
	// 70ns        1      1      1
	// 75ns        0      1      0
	// 80ns        0      1      0
	// 85ns        0      1      0
	// 90ns        1      0      0
	
	reg z; // Output z is declared as a register
	
	always @ (*)
	begin
		case({x, y}) // Using case statement to define the B waveform
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
	
	wire a1_z, a2_z, b1_z, b2_z, or_out, and_out;
	
	A a1(.x(x), .y(y), .z(a1_z));
	B b1(.x(x), .y(y), .z(b1_z));
	
	A a2(.x(x), .y(y), .z(a2_z));
	B b2(.x(x), .y(y), .z(b2_z));
	
	assign or_out = a1_z | b1_z;
	assign and_out = a2_z & b2_z;
	assign z = or_out ^ and_out;
	
endmodule
