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

	always @(x or y)
	begin
		case({x,y})
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

	A a1(.x(x), .y(y), .z(out1));
	B b1(.x(x), .y(y), .z(out2));
	A a2(.x(x), .y(y), .z(out3));
	B b2(.x(x), .y(y), .z(out4));

	assign z = out1 | out2 ^ out3 & out4;

endmodule
