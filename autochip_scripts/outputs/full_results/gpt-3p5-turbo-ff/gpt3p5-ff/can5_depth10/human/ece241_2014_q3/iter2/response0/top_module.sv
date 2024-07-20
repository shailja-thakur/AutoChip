module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

wire cd00 = 1'b0;
wire cd01 = 1'b1;
wire cd11 = 1'b1;
wire cd10 = 1'b1;

assign mux_in[0] = cd10;
assign mux_in[1] = ~cd00;
assign mux_in[2] = ~cd11;
assign mux_in[3] = ~cd10;

endmodule
