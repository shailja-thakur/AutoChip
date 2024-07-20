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

	reg x_reg;
	reg y_reg;
	
	always @(posedge clk) begin
		x_reg <= x;
		y_reg <= y;
		
		if (x_reg == 0 && y_reg == 0)
			z = 1;
		else if (x_reg == 1 && y_reg == 0)
			z = 0;
		else if (x_reg == 0 && y_reg == 1)
			z = 0;
		else if (x_reg == 1 && y_reg == 1)
			z = 1;
	end
	
endmodule
module top_module(
	input x,
	input y,
	output z);
	
	wire a_out1;
	wire b_out1;
	wire a_out2;
	wire b_out2;
	wire or_out;
	wire and_out;
	
	A a1(x, y, a_out1);
	B b1(x, y, b_out1);
	A a2(x, y, a_out2);
	B b2(x, y, b_out2);
	
	assign z = a_out1 | b_out1;
	
	assign or_out = a_out2 | b_out2;
	assign and_out = a_out2 & b_out2;
	assign z = or_out ^ and_out;
	
endmodule
