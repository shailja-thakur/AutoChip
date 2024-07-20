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
	
	reg z;
	
	initial begin
		z = 1;
		#5 z = 1;
		#5 z = 1;
		#5 z = 1;
		#5 z = 1;
		#5 z = 0;
		#5 z = 0;
		#5 z = 0;
		#5 z = 0;
		#5 z = 1;
		#5 z = 1;
		#5 z = 1;
		#5 z = 0;
		#5 z = 0;
		#5 z = 1;
		#5 z = 0;
		#5 z = 0;
		#5 z = 0;
		#5 z = 0;
		#5 z = 0;
	end
	
	assign z = z;
	
endmodule
module top_module(
	input x,
	input y,
	output z);
	
	wire a1_z;
	wire b1_z;
	wire a2_z;
	wire b2_z;
	wire or_output;
	wire and_output;
	
	A a1 (.x(x), .y(y), .z(a1_z));
	B b1 (.x(x), .y(y), .z(b1_z));
	A a2 (.x(x), .y(y), .z(a2_z));
	B b2 (.x(x), .y(y), .z(b2_z));
	
	or or_gate (.a(a1_z), .b(b1_z), .z(or_output));
	and and_gate (.a(a2_z), .b(b2_z), .z(and_output));
	
	xor xor_gate (.a(or_output), .b(and_output), .z(z));
	
endmodule
module or(
	input a,
	input b,
	output z);
	
	assign z = a | b;
	
endmodule
module and(
	input a,
	input b,
	output z);
	
	assign z = a & b;
	
endmodule
module xor(
	input a,
	input b,
	output z);
	
	assign z = a ^ b;
	
endmodule
