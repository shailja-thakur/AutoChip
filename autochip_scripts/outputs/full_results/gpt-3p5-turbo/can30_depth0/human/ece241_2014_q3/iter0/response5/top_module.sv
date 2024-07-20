module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

wire [1:0] ab;
wire [1:0] cd;

assign ab[0] = 0;
assign ab[1] = 1;
assign cd[0] = c & d;
assign cd[1] = c & ~d;

assign mux_in[0] = ab[0] & ~cd[1];
assign mux_in[1] = ab[0] & ~cd[0];
assign mux_in[2] = ab[0] & cd[0];
assign mux_in[3] = ab[0] & cd[1];

endmodule
