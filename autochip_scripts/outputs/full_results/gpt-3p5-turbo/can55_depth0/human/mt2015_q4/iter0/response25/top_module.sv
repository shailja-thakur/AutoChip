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
		#25 z = 1'b1;
		#5 z = 1'b0;
		#15 z = 1'b0;
		#5 z = 1'b1;
		#5 z = 1'b0;
		#20 z = 1'b1;
	end
	
	assign z = z;
endmodule
module top_module(
	input x,
	input y,
	output z);
	
	wire out_A1, out_A2, out_B1, out_B2;
	
	A A1(x, y, out_A1);
	B B1(x, y, out_B1);
	A A2(x, y, out_A2);
	B B2(x, y, out_B2);
	
	or or_gate(out_A1, out_B1, z_or);
	and and_gate(out_A2, out_B2, z_and);
	xor xor_gate(z_or, z_and, z);	
endmodule
