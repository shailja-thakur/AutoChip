module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

wire [1:0] ab;
assign ab = {c, d};

wire [3:0] mux_out;
assign mux_in[0] = (ab == 2'b00) ? mux_out[0] : 1'b0;
assign mux_in[1] = (ab == 2'b01) ? mux_out[1] : 1'b0;
assign mux_in[2] = (ab == 2'b10) ? mux_out[2] : 1'b0;
assign mux_in[3] = (ab == 2'b11) ? mux_out[3] : 1'b0;

assign mux_out[0] = ~(c & ~d);
assign mux_out[1] = c & ~d;
assign mux_out[2] = c;
assign mux_out[3] = ~(c ^ d);

endmodule
