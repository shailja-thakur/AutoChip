module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

wire temp1, temp2, temp3;

and gate1 (temp1, a, d);
and gate2 (temp2, b, c);
and gate3 (temp3, c, d);

or gate4 (out, temp1, temp2, temp3);

endmodule
