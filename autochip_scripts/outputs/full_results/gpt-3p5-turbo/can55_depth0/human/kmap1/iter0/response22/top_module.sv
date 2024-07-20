module top_module(
	input a, 
	input b,
	input c,
	output out
);

and gate_1(out1, a, b);
and gate_2(out2, !a, c);
and gate_3(out3, b, c);
or gate_4(out, out1, out2, out3);

endmodule
