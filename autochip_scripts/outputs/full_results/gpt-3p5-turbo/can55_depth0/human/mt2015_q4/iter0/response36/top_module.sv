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
	
	wire a1, a2, b1, b2, or_out, and_out;
	
	A A1(.x(x), .y(y), .z(a1));
	A A2(.x(x), .y(y), .z(a2));
	B B1(.x(x), .y(y), .z(b1));
	B B2(.x(x), .y(y), .z(b2));
	
	or or_gate(.a(a1), .b(b1), .z(or_out));
	and and_gate(.a(a2), .b(b2), .z(and_out));
	xor xor_gate(.a(or_out), .b(and_out), .z(z));
	
endmodule
