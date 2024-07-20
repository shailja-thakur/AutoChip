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

	always @(x or y)
	begin
		case({x, y})
			2'b00: z = 1;
			2'b10: z = 0;
			2'b01: z = 0;
			default: z = 1;
		endcase
	end

endmodule
module top_module(
	input x,
	input y,
	output z);

	wire z_1, z_2;

	A a1 (.x(x), .y(y), .z(z_1));
	A a2 (.x(x), .y(y), .z(z_2));

	B b1 (.x(x), .y(y), .z(z_1));
	B b2 (.x(x), .y(y), .z(z_2));

	or #(.WIDTH(1)) u_or (.a(z_1), .b(z_2), .z(z_1_or_z_2));
	and #(.WIDTH(1)) u_and (.a(z_1), .b(z_2), .z(z_1_and_z_2));
	xor #(.WIDTH(1)) u_xor (.a(z_1_or_z_2), .b(z_1_and_z_2), .z(z));

endmodule
