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
		#0		z = 1'b1;
		#5		z = 1'b1;
		#10		z = 1'b1;
		#15		z = 1'b1;
		#20		z = 1'b1;
		#25		z = 1'b0;
		#30		z = 1'b0;
		#35		z = 1'b0;
		#40		z = 1'b0;
		#45		z = 1'b1;
		#50		z = 1'b1;
		#55		z = 1'b1;
		#60		z = 1'b0;
		#65		z = 1'b0;
		#70		z = 1'b1;
		#75		z = 1'b0;
		#80		z = 1'b0;
		#85		z = 1'b0;
		#90		z = 1'b0;
	end
	
	assign z = z;
	
endmodule
module XOR_2(
	input a,
	input b,
	output z);

	assign z = a ^ b;
	
endmodule
module OR_2(
	input a,
	input b,
	output z);

	assign z = a | b;
	
endmodule
module AND_2(
	input a,
	input b,
	output z);

	assign z = a & b;
	
endmodule
module top_module(
	input x,
	input y,
	output z);
	
	A A1(.x(x), .y(y), .z(OR_2_1.z));
	B B1(.x(x), .y(y), .z(OR_2_1.z));
	A A2(.x(x), .y(y), .z(AND_2_1.z));
	B B2(.x(x), .y(y), .z(AND_2_1.z));
	OR_2 OR_2_1(.a(A1.z), .b(B1.z), .z(XOR_2_1.a));
	AND_2 AND_2_1(.a(A2.z), .b(B2.z), .z(XOR_2_1.b));
	XOR_2 XOR_2_1(.a(OR_2_1.z), .b(AND_2_1.z), .z(z));
	
endmodule
