module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

// Definitions for input combinations that generate logic-1 output
assign out_sop = (a & !b & !c & !d) | (!a & b & !c & !d) | (!a & !b & !c & d);

// Definitions for input combinations that generate logic-0 output
assign out_pos = (!a & !b & !c & !d) | (a & !b & c & !d) | (!a & b & c & !d) | (a & b & !c & !d) | (a & !b & !c & d) | (!a & b & !c & d) | (!a & !b & c & d) | (!a & !b & !c & d);

endmodule
