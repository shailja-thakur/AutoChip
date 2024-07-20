module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

wire w1, w2, w3;

and gate1 (w1, a, c);
and gate2 (w2, b, c);
or gate3 (w3, w1, w2, d);
assign out = w3;

endmodule
module and (
	output o,
	input a,
	input b
);
	assign o = a & b;
endmodule
module or (
	output o,
	input a,
	input b,
	input c
);
	assign o = a | b | c;
endmodule
