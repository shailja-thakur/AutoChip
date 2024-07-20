module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
); 

wire w1, w2, w3, w4, w5, w6, w7, w8;

and u1 (w1, ~a, ~b, ~c, ~d);
and u2 (w2, ~a, b, ~c, ~d);
and u3 (w3, a, b, ~c, ~d);
and u4 (w4, a, b, c, ~d);
and u5 (w5, ~a, ~b, c, ~d);
and u6 (w6, ~a, b, c, ~d);
and u7 (w7, ~a, b, ~c, d);
and u8 (w8, ~a, ~b, ~c, d);

or u9 (out, w1, w2, w3, w4, w5, w6, w7, w8);

endmodule
