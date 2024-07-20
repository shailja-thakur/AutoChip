module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

    wire w1, w2, w3, w4, w5, w6, w7, w8;

    and (w1, ~a, ~b);
    and (w2, ~b, ~c, ~d);
    or (w3, w1, w2);
    and (w4, a, ~c, ~d);
    or (w5, w2, w4);
    and (w6, b, ~c, d);
    or (w7, w1, w6);
    and (w8, a, b, ~c, d);
    or (out, w3, w5, w7, w8);

endmodule
