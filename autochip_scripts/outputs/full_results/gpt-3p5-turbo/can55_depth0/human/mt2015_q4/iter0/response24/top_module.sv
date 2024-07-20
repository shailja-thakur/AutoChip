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
	
	always @(x or y)
	begin
		case ({x, y})
			2'b00: z = 1'b1;
			2'b10: z = 1'b0;
			2'b01: z = 1'b0;
			2'b11: z = 1'b1;
			default: z = 1'b0;
		endcase
	end
	
endmodule
module top_module(
	input x,
	input y,
	output z);
	
	wire z_temp1, z_temp2, z_temp3;
	
	A inst1(.x(x), .y(y), .z(z_temp1));
	B inst2(.x(x), .y(y), .z(z_temp2));
	B inst3(.x(x), .y(y), .z(z_temp3));
	A inst4(.x(x), .y(y), .z(z_temp3));

	or gate1(.a(z_temp1), .b(z_temp2), .z(z_temp2));
	and gate2(.a(z_temp3), .b(z_temp4), .z(z_temp4));
	xor gate3(.a(z_temp2), .b(z_temp4), .z(z));
	
endmodule
