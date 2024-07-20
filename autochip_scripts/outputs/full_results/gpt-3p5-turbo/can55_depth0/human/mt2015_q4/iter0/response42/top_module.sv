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

	always @ (x or y)
		begin
			case ({x, y})
				2'b00 : z = 1'b1;
				2'b01 : z = 1'b0;
				2'b10 : z = 1'b0;
				2'b11 : z = 1'b1;
			endcase
		end
		
	assign z = z;
endmodule
module top_module(
	input x,
	input y,
	output z);

	wire [1:0] a_output;
	wire [1:0] b_output;
	wire or_output;
	wire and_output;

	A a1 (.x(x), .y(y), .z(a_output[0]));
	B b1 (.x(x), .y(y), .z(b_output[0]));
	A a2 (.x(x), .y(y), .z(a_output[1]));
	B b2 (.x(x), .y(y), .z(b_output[1]));

	assign or_output = a_output[0] | b_output[0];
	assign and_output = a_output[1] & b_output[1];
	assign z = or_output ^ and_output;

endmodule
