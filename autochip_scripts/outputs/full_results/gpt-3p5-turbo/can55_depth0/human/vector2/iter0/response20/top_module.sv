module top_module (
	input [31:0] in,
	output [31:0] out
);

	// instantiate the 8-bit reverse module 4 times
	reverse_bytes byte0 (.in(in[7:0]), .out(out[31:24]));
	reverse_bytes byte1 (.in(in[15:8]), .out(out[23:16]));
	reverse_bytes byte2 (.in(in[23:16]), .out(out[15:8]));
	reverse_bytes byte3 (.in(in[31:24]), .out(out[7:0]));

endmodule
module reverse_bytes (
	input [7:0] in,
	output [7:0] out
);
	
	// instantiate the 8-bit flip-flop module 8 times
	flip_flop ff0 (.in(in[0]), .out(out[0]));
	flip_flop ff1 (.in(in[1]), .out(out[1]));
	flip_flop ff2 (.in(in[2]), .out(out[2]));
	flip_flop ff3 (.in(in[3]), .out(out[3]));
	flip_flop ff4 (.in(in[4]), .out(out[4]));
	flip_flop ff5 (.in(in[5]), .out(out[5]));
	flip_flop ff6 (.in(in[6]), .out(out[6]));
	flip_flop ff7 (.in(in[7]), .out(out[7]));

endmodule
module flip_flop (
	input in,
	output out
);
	reg out;

	always @(posedge in)
		out <= in;

endmodule
