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
	
	// Simulation waveform
	initial begin
		#0 x=0; y=0; z=1;
		#5 x=0; y=0; z=1;
		#10 x=0; y=0; z=1;
		#15 x=0; y=0; z=1;
		#20 x=0; y=0; z=1;
		#25 x=1; y=0; z=0;
		#30 x=1; y=0; z=0;
		#35 x=0; y=1; z=0;
		#40 x=0; y=1; z=0;
		#45 x=1; y=1; z=1;
		#50 x=1; y=1; z=1;
		#55 x=0; y=0; z=1;
		#60 x=0; y=1; z=0;
		#65 x=0; y=1; z=0;
		#70 x=1; y=1; z=1;
		#75 x=0; y=1; z=0;
		#80 x=0; y=1; z=0;
		#85 x=0; y=1; z=0;
		#90 x=1; y=0; z=0;
		#100 $finish;
	end
	
	assign z = 1;
	
endmodule
module top_module(
	input x,
	input y,
	output z);
	
	wire a1_z, a2_z, b1_z, b2_z, or_out, and_out;
	
	A A1(x, y, a1_z);
	B B1(x, y, b1_z);
	
	A A2(x, y, a2_z);
	B B2(x, y, b2_z);
	
	assign or_out = a1_z | b1_z;
	assign and_out = a2_z & b2_z;
	assign z = or_out ^ and_out;
	
endmodule
