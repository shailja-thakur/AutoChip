module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

reg [1:0] ab;
wire [1:0] ab_in;

assign ab_in = {a, b};

assign mux_in[0] = ~(c & d);
assign mux_in[1] = c & (~d);
assign mux_in[2] = (c & ~d) | (~c & d);
assign mux_in[3] = (c & d) | (~c & d);

endmodule
