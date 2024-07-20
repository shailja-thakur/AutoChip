module A (
	input x,
	input y,
	output z
);
	assign z = (x ^ y) & x;
endmodule
module B (
	input x,
	input y,
	output z
);
	reg z;
	initial begin
		#0;
		z = 1;
		#50;
		z = 0;
		#15;
		z = 0;
		#25;
		z = 1;
		#10;
		z = 0;
		#5;
		z = 1;
		#35;
		z = 0;
		#15;
		z = 1;
		#0;
		z = 0;
	end
endmodule
module top_module (
	input x,
	input y,
	output z
);
	A a1 (.x(x), .y(y), .z(u1));
	B b1 (.x(x), .y(y), .z(u2));
	A a2 (.x(x), .y(y), .z(u3));
	B b2 (.x(x), .y(y), .z(u4));

	or #(.WIDTH(1)) or_gate(.a(u1), .b(u2), .z(u5));
	and #(.WIDTH(1)) and_gate(.a(u3), .b(u4), .z(u6));
	xor #(.WIDTH(1)) xor_gate(.a(u5), .b(u6), .z(z));
endmodule
