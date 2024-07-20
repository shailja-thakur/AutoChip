module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	wire inter1;
	wire inter2;

	andgate and1(a, b, inter1);
	andgate and2(c, d, inter2);
	orgate or1(inter1, inter2, out);
	notgate not1(out, out_n);

endmodule
module andgate (
  input a,
  input b,
  output out
);

	assign out = a & b;

endmodule
module orgate (
  input a,
  input b,
  output out
);

	assign out = a | b;

endmodule
module notgate (
  input a,
  output out
);

	assign out = ~a;

endmodule
