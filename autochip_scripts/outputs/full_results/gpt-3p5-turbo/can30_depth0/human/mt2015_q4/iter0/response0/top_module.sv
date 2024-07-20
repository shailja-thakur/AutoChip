module a(
	input x,
	input y,
	output z);
	
	assign z = (x ^ y) & x;
endmodule
module b(
	input x,
	input y,
	output z);
	
	reg z;
	
	always @(x, y)
	begin
		case({x, y})
			2'b00: z <= 1;
			2'b01: z <= 0;
			2'b10: z <= 0;
			2'b11: z <= 1;
			default: z <= 1;
		endcase
	end
endmodule
module top_module(
	input x,
	input y,
	output z);
	
	wire a_out1, a_out2, b_out1, b_out2;
	wire or_out, and_out;
	
	a a1(x, y, a_out1);
	a a2(x, y, a_out2);
	b b1(x, y, b_out1);
	b b2(x, y, b_out2);
	
	assign or_out = a_out1 | b_out1;
	assign and_out = a_out2 & b_out2;
	assign z = or_out ^ and_out;
endmodule
