module a_module(
	input x,
	input y,
	output z);

	assign z = (x ^ y) & x;
	
endmodule
module b_module(
	input x,
	input y,
	output z);
	
	initial
		begin
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
		end
	
endmodule
module top_module(
	input x,
	input y,
	output z);
	
	wire a1, a2, b1, b2;
	
	a_module a1_module(
		.x(x),
		.y(y),
		.z(a1)
	);
	
	b_module b1_module(
		.x(x),
		.y(y),
		.z(b1)
	);
	
	a_module a2_module(
		.x(x),
		.y(y),
		.z(a2)
	);
	
	b_module b2_module(
		.x(x),
		.y(y),
		.z(b2)
	);
	
	assign z = (a1 | b1) ^ (a2 & b2);
	
endmodule
