module A(
	input x,
	input y,
	output z);

	assign z = (x^y) & x;

endmodule
module B(
	input x,
	input y,
	output z);

	reg z;

	always @(*) begin
		case({x,y})
			2'b00 : z = 1;
			2'b01, 2'b10, 2'b11 : z = 0;
		endcase
	end

endmodule
module top_module(
	input x,
	input y,
	output z);

	wire a_out_1, a_out_2, b_out_1, b_out_2;

	A a1(.x(x), .y(y), .z(a_out_1));
	B b1(.x(x), .y(y), .z(b_out_1));

	A a2(.x(x), .y(y), .z(a_out_2));
	B b2(.x(x), .y(y), .z(b_out_2));

	assign z = (a_out_1 | b_out_1) ^ (a_out_2 & b_out_2);

endmodule
