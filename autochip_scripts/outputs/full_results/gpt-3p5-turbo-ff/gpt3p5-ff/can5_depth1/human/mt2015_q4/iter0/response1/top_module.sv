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
		#0 z = 1'b1;
		#5 z = 1'b1;
		#10 z = 1'b1;
		#15 z = 1'b1;
		#20 z = 1'b1;
		#25 z = x & ~y;
		#30 z = x & ~y;
		#35 z = ~x & y;
		#40 z = ~x & y;
		#45 z = 1'b1;
		#50 z = 1'b1;
		#55 z = 1'b1;
		#60 z = ~x & y;
		#65 z = ~x & y;
		#70 z = 1'b1;
		#75 z = ~x & y;
		#80 z = ~x & y;
		#85 z = ~x & y;
		#90 z = x & ~y;
	end
	
	assign z = z;
	
endmodule
module top_module(
	input x,
	input y,
	output z);
	
	wire a_out1, a_out2, b_out1, b_out2;
	
	A a1(
		.x(x),
		.y(y),
		.z(a_out1)
	);
	
	B b1(
		.x(x),
		.y(y),
		.z(b_out1)
	);
	
	A a2(
		.x(x),
		.y(y),
		.z(a_out2)
	);
	
	B b2(
		.x(x),
		.y(y),
		.z(b_out2)
	);
	
	assign z = (a_out1 | b_out1) ^ (a_out2 & b_out2);
	
endmodule
