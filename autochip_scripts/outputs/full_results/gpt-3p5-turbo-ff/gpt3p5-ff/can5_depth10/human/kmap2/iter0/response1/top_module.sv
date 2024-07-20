module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

// Implementing the circuit described by the Karnaugh map

wire w1, w2, w3, w4;

and #5 u1 (.a(a), .b(b), .out(w1));
and #5 u2 (.a(c), .b(d), .out(w2));
and #5 u3 (.a(a), .b(!b), .c(c), .out(w3));
and #5 u4 (.a(b), .b(d), .out(w4));
or #5 u5 (.a(w1), .b(w2), .c(w3), .d(w4), .out(out));

endmodule
