module top_module (
	input [3:0] in,
	output [2:0] out_both,
	output [3:1] out_any,
	output [3:0] out_different
);

	// Combinational logic for out_both
	assign out_both[0] = in[0] & in[3]; // Input bit 0 and its neighbor to the left (bit 3)
	assign out_both[1] = in[1] & in[0]; // Input bit 1 and its neighbor to the left (bit 0)
	assign out_both[2] = in[2] & in[1]; // Input bit 2 and its neighbor to the left (bit 1)

	// Combinational logic for out_any
	assign out_any[1] = in[2] | in[1]; // Input bit 2 or its neighbor to the right (bit 1)
	assign out_any[2] = in[3] | in[2]; // Input bit 3 or its neighbor to the right (bit 2)
	assign out_any[3] = in[0] | in[3]; // Input bit 0 or its neighbor to the right (bit 3)

	// Combinational logic for out_different
	assign out_different[0] = in[0] != in[3]; // Input bit 0 is different from its neighbor to the left (bit 3)
	assign out_different[1] = in[1] != in[0]; // Input bit 1 is different from its neighbor to the left (bit 0)
	assign out_different[2] = in[2] != in[1]; // Input bit 2 is different from its neighbor to the left (bit 1)
	assign out_different[3] = in[3] != in[2]; // Input bit 3 is different from its neighbor to the left (bit 2)

endmodule
