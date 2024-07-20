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
			default: z = 1;
		endcase
	end
	
endmodule
module top_module(
	input x,
	input y,
	output z);
	
	A A1(.x(x), .y(y), .z(A1_z));
	B B1(.x(x), .y(y), .z(B1_z));
	
	A A2(.x(x), .y(y), .z(A2_z));
	B B2(.x(x), .y(y), .z(B2_z));
	
	wire or_out;
	wire and_out;
	
	assign or_out = A1_z | B1_z;
	assign and_out = A2_z & B2_z;
	
	assign z = or_out ^ and_out;
	
endmodule
