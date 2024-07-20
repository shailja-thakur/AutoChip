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
	
	always @(x or y) begin
		case({x, y})
			2'b00: z = 1;
			2'b01: z = 0;
			2'b10: z = 0;
			2'b11: z = 1;
		endcase
	end
	
	assign z = z; // added this line to make sure 'z' is continuously driven
endmodule
module top_module(
	input x,
	input y,
	output z);
	
	wire a1_out, b1_out, a2_out, b2_out, or_out, and_out;
	
	A a1(.x(x), .y(y), .z(a1_out));
	B b1(.x(x), .y(y), .z(b1_out));
	
	A a2(.x(x), .y(y), .z(a2_out));
	B b2(.x(x), .y(y), .z(b2_out));
	
	assign or_out = a1_out | b1_out;
	assign and_out = a2_out & b2_out;
	assign z = xor(or_out, and_out);
endmodule
