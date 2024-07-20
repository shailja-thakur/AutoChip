module top_module (
	input wire c,
	input wire d,
	output wire [3:0] mux_in
);

	assign mux_in[0] = (c & d) | (~c & d);
	assign mux_in[1] = 1'b0;
	assign mux_in[2] = (c & ~d) | (c & d);
	assign mux_in[3] = (d & ~c) | (c & d);

endmodule
