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
	
	initial
	begin
		z = 1;
		#5 z = 1;
		#5 z = 1;
		#5 z = 1;
		#5 z = 1;
		#5 z = 0;
		#5 z = 0;
		#5 z = 0;
		#5 z = 0;
		#5 z = 1;
		#5 z = 1;
		#5 z = 1;
		#5 z = 0;
		#5 z = 0;
		#5 z = 0;
		#5 z = 1;
		#5 z = 0;
		#5 z = 0;
		#5 z = 0;
		#5 z = 1;
	end
	
	assign z = z;
	
endmodule
module top_module(
	input x,
	input y,
	output z);
	
	wire a_out1, a_out2, b_out1, b_out2;
	
	A a1(.x(x), .y(y), .z(a_out1));
	A a2(.x(x), .y(y), .z(a_out2));
	B b1(.x(x), .y(y), .z(b_out1));
	B b2(.x(x), .y(y), .z(b_out2));
	
	wire or_out, and_out;
	
	assign or_out = a_out1 | b_out1;
	assign and_out = a_out2 & b_out2;
	assign z = or_out ^ and_out;
	
endmodule
