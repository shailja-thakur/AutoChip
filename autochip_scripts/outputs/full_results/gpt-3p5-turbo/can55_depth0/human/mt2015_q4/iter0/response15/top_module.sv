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
	
	reg x_reg, y_reg;
	
	always @(negedge clk) begin
		x_reg <= x;
		y_reg <= y;
	end
	
	always @(posedge clk) begin
		z <= x_reg & y_reg;
	end
	
endmodule
module top_module(
	input x,
	input y,
	output z);
	
	wire a_out1, a_out2, b_out1, b_out2, or_out, and_out;
	
	A A1(.x(x), .y(y), .z(a_out1));
	A A2(.x(x), .y(y), .z(a_out2));
	B B1(.x(x), .y(y), .z(b_out1));
	B B2(.x(x), .y(y), .z(b_out2));
	
	assign or_out = a_out1 | b_out1;
	assign and_out = a_out2 & b_out2;
	assign z = or_out ^ and_out;
	
endmodule
