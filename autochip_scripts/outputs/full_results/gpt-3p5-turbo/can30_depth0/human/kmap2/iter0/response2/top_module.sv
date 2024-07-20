module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

// Implement the circuit described by the Karnaugh map

wire w1, w2, w3, w4;

and u1 (wire1, a, c);
and u2 (wire2, b, d);
and u3 (wire3, a, b);
and u4 (wire4, c, d);

or u5 (out, wire1, wire2, wire3, wire4);

endmodule
