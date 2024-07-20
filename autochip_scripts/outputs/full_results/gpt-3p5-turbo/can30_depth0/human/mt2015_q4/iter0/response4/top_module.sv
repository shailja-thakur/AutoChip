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
	initial begin
		z = 1;
		#5 z = 0;
		#20 z = 1;
		#10 z = 0;
		#15 z = 1;
		#5 z = 0;
		#40 z = 0;
		#5 z = 1;
		#5 z = 0;
		#5 z = 1;
		#5 z = 0;
		#5 z = 0;
	end
	
endmodule
module top_module(
	input x,
	input y,
	output z);
	
	wire a_out1, a_out2, b_out1, b_out2;
	wire or_out, and_out;
	
	A a1(x, y, a_out1);
	A a2(x, y, a_out2);
	B b1(x, y, b_out1);
	B b2(x, y, b_out2);
	
	assign z = a_out1 | b_out1 ^ (a_out2 & b_out2);
	
endmodule
