module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

wire temp1;
wire temp2;
wire temp3;
wire temp4;

and #(1) u1 (temp1, a, b);
and #(1) u2 (temp2, c, d);
and #(1) u3 (temp3, a, c);
and #(1) u4 (temp4, b, d);

or #(1) u5 (out, temp1, temp2, temp3, temp4);

endmodule
