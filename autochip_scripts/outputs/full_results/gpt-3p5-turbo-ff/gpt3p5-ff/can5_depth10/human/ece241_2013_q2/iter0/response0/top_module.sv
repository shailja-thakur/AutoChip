module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

	// Intermediate signals
	wire intermediate_sop;
	wire intermediate_pos;

	// Logic for out_sop
	assign intermediate_sop = (a & !b & !c & !d) | (!a & b & c & d) | (!a & !b & !c & d);
	assign out_sop = intermediate_sop;

	// Logic for out_pos
	assign intermediate_pos = (a | b | !c | !d) & (!a | !b | c | d) & (!a | b | !c | d);
	assign out_pos = intermediate_pos;

endmodule
