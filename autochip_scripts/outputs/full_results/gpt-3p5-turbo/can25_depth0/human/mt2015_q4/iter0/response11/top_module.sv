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
	
	always @*
		begin
			case({x, y})
				2'b00: z = 1'b1;
				2'b01, 2'b10: z = 1'b0;
				2'b11: z = 1'b1;
			endcase
		end
endmodule
module top_module(
	input x,
	input y,
	output z);
	
	wire a_output1;
	wire a_output2;
	wire b_output1;
	wire b_output2;
	wire or_output;
	wire and_output;
	
	A a1 (
		.x(x),
		.y(y),
		.z(a_output1)
	);
	
	B b1 (
		.x(x),
		.y(y),
		.z(b_output1)
	);
	
	A a2 (
		.x(x),
		.y(y),
		.z(a_output2)
	);
	
	B b2 (
		.x(x),
		.y(y),
		.z(b_output2)
	);
	
	assign or_output = a_output1 | b_output1;
	assign and_output = a_output2 & b_output2;
	
	assign z = or_output ^ and_output;
	
endmodule
