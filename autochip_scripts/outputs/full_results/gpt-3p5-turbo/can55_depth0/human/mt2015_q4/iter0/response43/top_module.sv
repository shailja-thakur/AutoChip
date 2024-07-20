module A(input x, input y, output z);

	assign z = (x ^ y) & x;

endmodule
module B(input x, input y, output z);

	always @(x or y)
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

	wire a_out1, a_out2, b_out1, b_out2;
	or u_or(a_out1, A_out1, B_out1);
	and u_and(a_out2, A_out2, B_out2);
	xor u_xor(z, a_out1, a_out2);

	A u_A1(x, y, A_out1);
	B u_B1(x, y, B_out1);
	A u_A2(x, y, A_out2);
	B u_B2(x, y, B_out2);

endmodule
