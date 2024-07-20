module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

reg [255:0] mux_out;

always @(*) begin
	case (sel)
		0: mux_out = in[0];
		1: mux_out = in[1];
		2: mux_out = in[2];
		3: mux_out = in[3];
		4: mux_out = in[4];
		5: mux_out = in[5];
		6: mux_out = in[6];
		7: mux_out = in[7];
		default: mux_out = in[0];
	endcase
end

assign out = mux_out;

endmodule
