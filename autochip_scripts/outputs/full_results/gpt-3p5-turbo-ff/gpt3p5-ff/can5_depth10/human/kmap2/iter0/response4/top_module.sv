module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

wire w1, w2, w3, w4;

// Implementing the Karnaugh map

and and1(w1, ~a, ~b, c, ~d);
and and2(w2, ~a, ~b, c, d);
and and3(w3, a, b, c, d);
and and4(w4, a, b, ~c, ~d);
or or1(out, w1, w2, ~w3, w4);

endmodule
