module and_gate(
	input a,
	input b,
	output c);
	
	assign c = a & b;
	
endmodule
module or_gate(
	input a,
	input b,
	output c);
	
	assign c = a | b;
	
endmodule
module xor_gate(
	input a,
	input b,
	output c);
	
	assign c = a ^ b;
	
endmodule
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
	
	reg z_reg;
	
	always @(x or y)
	begin
		case({x, y})
			2'b00: z_reg <= 1'b1;
			2'b01: z_reg <= 1'b0;
			2'b10: z_reg <= 1'b0;
			2'b11: z_reg <= 1'b1;
		endcase
	end
	
	assign z = z_reg;
	
endmodule
module top_module(
	input x,
	input y,
	output z);
	
	wire or_out, and_out;
	
	A a1(x, y, a1_z);
	A a2(x, y, a2_z);
	B b1(x, y, b1_z);
	B b2(x, y, b2_z);
	
	or_gate or1(a1_z, b1_z, or_out);
	and_gate and1(a2_z, b2_z, and_out);
	xor_gate xor1(or_out, and_out, z);
	
endmodule
