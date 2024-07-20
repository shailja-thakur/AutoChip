module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

wire ab_00, ab_01, ab_11, ab_10;
assign ab_00 = 1'b0;
assign ab_01 = 1'b0;
assign ab_11 = 1'b0;
assign ab_10 = 1'b1;

wire mux_in_0, mux_in_1, mux_in_2, mux_in_3;
assign mux_in_0 = (c & d & ab_00) | (~c & d & ab_01);
assign mux_in_1 = (c & d & ab_01) | (~c & ~d & ab_11);
assign mux_in_2 = (c & ~d & ab_11) | (~c & d & ab_10);
assign mux_in_3 = (c & d & ab_10) | (c & ~d & ab_11) | (~c & ~d & ab_10);

assign mux_in = {mux_in_3, mux_in_2, mux_in_1, mux_in_0};

endmodule
