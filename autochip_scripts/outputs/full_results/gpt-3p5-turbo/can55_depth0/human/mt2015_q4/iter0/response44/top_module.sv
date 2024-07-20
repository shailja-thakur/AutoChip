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
	
	always @(x, y)
	begin
		case({x, y})
			2'b00: z = 1'b1;
			2'b01: z = 1'b0;
			2'b10: z = 1'b0;
			2'b11: z = 1'b1;
		endcase
	end
	
endmodule
module top_module(
	input x,
	input y,
	output z);
	
	wire z_A1, z_A2, z_B1, z_B2, z_OR, z_AND;
	
	A A1(x, y, z_A1);
	A A2(x, y, z_A2);
	B B1(x, y, z_B1);
	B B2(x, y, z_B2);
	
	or_gate OR_gate(z_A1, z_B1, z_OR);
	and_gate AND_gate(z_A2, z_B2, z_AND);
	
	xor_gate XOR_gate(z_OR, z_AND, z);
	
endmodule
