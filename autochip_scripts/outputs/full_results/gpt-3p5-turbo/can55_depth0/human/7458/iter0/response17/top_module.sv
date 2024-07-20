module top_module(
	input p1a, 
	input p1b, 
	input p1c, 
	input p1d,
	input p1e,
	input p1f,
	output p1y, 
	input p2a, 
	input p2b, 
	input p2c, 
	input p2d, 
	output p2y
);

wire p1y_internal;
wire p2y_internal;

and gate1 (p1y_internal, p1a, p1b, p1c);
and gate2 (p2y_internal, p1d, p1e, p1f);
or gate3 (p1y, p1y_internal, p2y_internal);

and gate4 (p2y_internal, p2a, p2b);
and gate5 (p2y_internal, p2c, p2d);

endmodule
module and (
	output and_out,
	input and_in1,
	input and_in2,
	input and_in3
);

assign and_out = and_in1 & and_in2 & and_in3;

endmodule
module or (
	output or_out,
	input or_in1,
	input or_in2
);

assign or_out = or_in1 | or_in2;

endmodule
