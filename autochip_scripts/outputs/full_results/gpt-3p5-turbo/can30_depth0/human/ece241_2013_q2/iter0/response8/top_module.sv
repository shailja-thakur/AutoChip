module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

wire out;

and(out_sop,a,!b,!c,!d);
and(out_sop,!a,!b,c,!d);
and(out_sop,a,!b,!c,d);

or(out_pos,!a,b,!c,!d);
or(out_pos,a,!b,c,!d);
or(out_pos,!a,b,c,!d);
or(out_pos,a,b,c,!d);
or(out_pos,!a,b,!c,d);
or(out_pos,a,!b,c,d);
or(out_pos,!a,b,c,d);
or(out_pos,a,b,!c,d);

assign out = out_sop;

endmodule
