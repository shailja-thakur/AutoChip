module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

wire w1, w2, w3;

and #(.delay(1)) g1 (w1, a, b);
and #(.delay(1)) g2 (w2, a, cin);
and #(.delay(1)) g3 (w3, b, cin);

or #(.delay(1)) g4 (sum, w1, w2, w3);

and #(.delay(1)) g5 (cout, w1, w2);
or #(.delay(1)) g6 (cout, w1, w3);
or #(.delay(1)) g7 (cout, w2, w3);

endmodule
