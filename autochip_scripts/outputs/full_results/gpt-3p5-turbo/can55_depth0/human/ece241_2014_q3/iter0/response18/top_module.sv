module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

wire [1:0] ab;
assign ab[0] = 0;
assign ab[1] = 0;

assign mux_in[0] = (c & d & ab[0]) | (c & ~d & ab[1]);
assign mux_in[1] = (c & ~d & ab[0]);
assign mux_in[2] = (c & ~d & ab[0]) | (~c & ~d & ab[1]);
assign mux_in[3] = (c & d & ab[1]) | (c & ~d & ab[0]) | (~c & ~d & ab[1]);

endmodule
