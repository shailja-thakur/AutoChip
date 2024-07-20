module module_A(
	input x,
	input y,
	output z);
	
	assign z = (x ^ y) & x;
	
endmodule
module module_B(
	input x,
	input y,
	output z);
	
	always @(x or y)
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
	
	wire a_out1, a_out2, b_out1, b_out2;
	wire or_out, and_out;
	
	module_A A1(.x(x), .y(y), .z(a_out1));
	module_A A2(.x(x), .y(y), .z(a_out2));
	module_B B1(.x(x), .y(y), .z(b_out1));
	module_B B2(.x(x), .y(y), .z(b_out2));
	
	assign or_out = a_out1 | b_out1;
	assign and_out = a_out2 & b_out2;
	assign z = or_out ^ and_out;
	
endmodule
