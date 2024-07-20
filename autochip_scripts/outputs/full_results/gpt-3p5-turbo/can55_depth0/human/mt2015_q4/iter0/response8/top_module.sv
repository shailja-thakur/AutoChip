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
	
	assign z = #(5ns,10ns,15ns) 1'b1;
	assign z = #(25ns,30ns) 1'b0;
	assign z = #(35ns,40ns,60ns,65ns) 1'b0;
	assign z = #(45ns,50ns,70ns) 1'b1;
	assign z = #(55ns,85ns) 1'b1;
	assign z = #(75ns,80ns) 1'b0;
	assign z = 1'b1;
	
endmodule
module top_module(
	input x,
	input y,
	output z);
	
	A a1(
		.x(x),
		.y(y),
		.z(a_z1)
	);
	
	A a2(
		.x(x),
		.y(y),
		.z(a_z2)
	);
	
	B b1(
		.x(x),
		.y(y),
		.z(b_z1)
	);
	
	B b2(
		.x(x),
		.y(y),
		.z(b_z2)
	);
	
	or_gate or1(
		.in1(a_z1),
		.in2(b_z1),
		.out(or_out)
	);
	
	and_gate and1(
		.in1(a_z2),
		.in2(b_z2),
		.out(and_out)
	);
	
	xor_gate xor1(
		.in1(or_out),
		.in2(and_out),
		.out(z)
	);
	
endmodule
module or_gate(
	input in1,
	input in2,
	output out);
	
	assign out = in1 | in2;
	
endmodule
module and_gate(
	input in1,
	input in2,
	output out);
	
	assign out = in1 & in2;
	
endmodule
module xor_gate(
	input in1,
	input in2,
	output out);
	
	assign out = in1 ^ in2;
	
endmodule
