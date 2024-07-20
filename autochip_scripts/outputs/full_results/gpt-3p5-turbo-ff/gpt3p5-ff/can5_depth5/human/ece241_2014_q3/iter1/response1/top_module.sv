module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

wire ab_00, ab_01, ab_11, ab_10;

assign ab_00 = 1'b0;
assign ab_01 = 1'b1;
assign ab_11 = 1'b1;
assign ab_10 = 1'b1;

assign mux_in[0] = (ab_00 & !c & !d) | (!ab_00 & c & !d);
assign mux_in[1] = (!ab_01 & !c & d) | (ab_01 & !c & !d);
assign mux_in[2] = (ab_11 & !c & d) | (!ab_11 & c & d);
assign mux_in[3] = (!ab_10 & !c & d) | (!ab_10 & c & d);

endmodule
