module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

wire mux_in_0, mux_in_1, mux_in_2, mux_in_3;

assign mux_in_0 = (c & d) ? 1'b0 : 1'b1;
assign mux_in_1 = (c & ~d) ? 1'b1 : 1'b0;
assign mux_in_2 = (c | ~d) ? 1'b1 : 1'b0;
assign mux_in_3 = (c & d) ? 1'b1 : 1'b0;

always @* begin
	case({a, b})
		2'b00: mux_in = mux_in_0;
		2'b01: mux_in = mux_in_1;
		2'b11: mux_in = mux_in_2;
		2'b10: mux_in = mux_in_3;
	endcase
end

endmodule
