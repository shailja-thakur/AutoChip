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
	
	reg x_reg, y_reg;
	wire z_int;
	
	always @(x or y) begin
		x_reg <= x;
		y_reg <= y;

		#5 // Delay of 5 ns
	end
	
	always @(posedge clk) begin
		case ({x_reg, y_reg})
			2'b00: z_int <= 1'b1;
			2'b01: z_int <= 1'b0;
			2'b10: z_int <= 1'b0;
			2'b11: z_int <= 1'b1;
		endcase
	end
	
	assign z = z_int;	
endmodule
module top_module(
	input x,
	input y,
	output z);
	
	reg a1_z, b1_z, a2_z, b2_z, or_out, and_out;
	
	A a1(x, y, a1_z);
	B b1(x, y, b1_z);
	A a2(x, y, a2_z);
	B b2(x, y, b2_z);
	
	assign or_out = a1_z | b1_z;
	assign and_out = a2_z & b2_z;
	assign z = or_out ^ and_out;
	
endmodule
