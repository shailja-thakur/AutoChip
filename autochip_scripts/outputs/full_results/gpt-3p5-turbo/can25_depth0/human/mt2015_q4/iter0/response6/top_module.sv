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
	
	always @(x, y)
	begin
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
	
	wire z1, z2;
	
	A a1(x, y, z1);
	
	B b1(x, y, z2);
	
	B b2(x, y, z3);
	
	A a2(z2, z3, z);
	
	or #(.WIDTH(1)) or_gate(z1, z2, z4);
	
	and #(.WIDTH(1)) and_gate(z1, z2, z5);
	
	xor #(.WIDTH(1)) xor_gate(z4, z5, z);
	
endmodule
module or #(
	parameter WIDTH = 1
)(
	input [WIDTH-1:0] a,
	input [WIDTH-1:0] b,
	output [WIDTH-1:0] c
);

	assign c = a | b;
	
endmodule
module and #(
	parameter WIDTH = 1
)(
	input [WIDTH-1:0] a,
	input [WIDTH-1:0] b,
	output [WIDTH-1:0] c
);

	assign c = a & b;
	
endmodule
module xor #(
	parameter WIDTH = 1
)(
	input [WIDTH-1:0] a,
	input [WIDTH-1:0] b,
	output [WIDTH-1:0] c
);

	assign c = a ^ b;
	
endmodule
