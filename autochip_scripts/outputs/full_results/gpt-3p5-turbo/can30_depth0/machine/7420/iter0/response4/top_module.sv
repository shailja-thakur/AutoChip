module top_module(
	input  p1a, 
	input  p1b, 
	input  p1c, 
	input  p1d, 
	output p1y, 
	input  p2a, 
	input  p2b, 
	input  p2c, 
	input  p2d, 
	output p2y
);

	/* Internal wires */
	wire p1and, p2and;
	wire p1ynot, p2ynot;

	/* AND gates */
	and u1(p1and, p1a, p1b, p1c, p1d);
	and u2(p2and, p2a, p2b, p2c, p2d);

	/* Inverters */
	not u3(p1ynot, p1and);
	not u4(p2ynot, p2and);

	/* Outputs */
	assign p1y = p1ynot;
	assign p2y = p2ynot;

endmodule
module and(
	output  o,
	input   i1,
	input   i2,
	input   i3,
	input   i4
);
	assign o = i1 & i2 & i3 & i4;
endmodule
module not(
	output  o,
	input   i
);
	assign o = ~i;
endmodule
