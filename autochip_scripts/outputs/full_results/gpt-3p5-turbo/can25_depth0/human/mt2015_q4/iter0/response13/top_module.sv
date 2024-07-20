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

	always @(x, y) begin
		case({x, y})
			2'b01: z = 0;
			2'b10: z = 0;
			2'b11: z = 1;
			default: z = 0;
		endcase
	end

endmodule
module top_module(
	input x,
	input y,
	output z);

	wire a_out, b_out;
	A a1(x, y, a_out);
	B b1(x, y, b_out);

	OR gate1(a_out, b_out, z);
	AND gate2(a_out, b_out, z);
	XOR gate3(z, z, z);

endmodule
