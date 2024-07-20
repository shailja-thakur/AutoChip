module top_module (
	input [2:0] in,
	output [1:0] out
);
	// First stage
	wire [1:0] stage1_out;
	POP_COUNT_2 pop_count_2_1 (
		.in(in[0:1]),
		.out(stage1_out)
	);
	
	// Second stage
	wire [1:0] stage2_out;
	POP_COUNT_2 pop_count_2_2 (
		.in(in[1:2]),
		.out(stage2_out)
	);
	
	// Third stage
	POP_COUNT_2 pop_count_2_3 (
		.in(stage1_out[1], stage2_out[0]),
		.out(out)
	);
	
endmodule
module POP_COUNT_2 (
	input [1:0] in,
	output [1:0] out
);
	assign out[0] = in[0] ^ in[1];
	assign out[1] = in[0] & in[1];
endmodule
