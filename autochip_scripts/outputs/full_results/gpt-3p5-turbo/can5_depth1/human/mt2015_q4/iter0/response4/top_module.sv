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
  
	reg z;
  
	initial begin
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

	wire a1, b1, a2, b2;
  
	A a_inst1(
		.x(x),
		.y(y),
		.z(a1)
	);
  
	B b_inst1(
		.x(x),
		.y(y),
		.z(b1)
	);
  
    A a_inst2(
		.x(x),
		.y(y),
		.z(a2)
	);
  
	B b_inst2(
		.x(x),
		.y(y),
		.z(b2)
	);
  
	or #4 or_gate(
		.a(a1),
		.b(b1),
		.z(z)
	);
  
	and #4 and_gate(
		.a(a2),
		.b(b2),
		.z(z)
	);
  
	assign z = a1 ^ b1;
  
endmodule
