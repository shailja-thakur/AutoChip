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
			2'b00: z = 1'b1;
			2'b10: z = 1'b0;
			2'b01: z = 1'b0;
			2'b11: z = 1'b1;
		endcase
	end
	
endmodule
module top_module(
	input x,
	input y,
	output z);
	
	wire a1_out, a2_out, b1_out, b2_out;
	
	A a1(.x(x), .y(y), .z(a1_out));
	A a2(.x(x), .y(y), .z(a2_out));
	
	B b1(.x(x), .y(y), .z(b1_out));
	B b2(.x(x), .y(y), .z(b2_out));
	
	assign z = a1_out | b1_out ^ a2_out & b2_out;
	
endmodule
