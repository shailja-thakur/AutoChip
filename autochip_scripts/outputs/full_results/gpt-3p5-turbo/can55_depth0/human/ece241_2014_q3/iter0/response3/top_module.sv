module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

wire a, b;
/* implementing the inputs a, b as per the K-map */
and u1 (a, c, d);
nand u2 (b, c, d);
/* implementing the mux inputs as per the K-map */

not na0(ab1, c), na1(ab0, d), 	na2(ab2, not(c), d), na3(ab3, c, d);
or o0 (mux_in[0], ab2, ab1);
or o1 (mux_in[1], na1, na0);
or o2 (mux_in[2], ab3, na2);
or o3 (mux_in[3], ab0, na3);

endmodule
