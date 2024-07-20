module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

    // intermediate signals
    wire w1, w2, w3, w4, w5, w6, w7, w8;

    // logic gates
    xor (w1, a, c);
    xor (w2, a, b);
    xor (w3, a, d);
    xor (w4, b, c);
    xor (w5, b, d);
    xor (w6, c, d);
    and (w7, w1, w3, w5, w6);
    and (w8, w2, w4, w6);
    or (out, w7, w8);

endmodule
