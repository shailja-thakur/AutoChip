module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

reg [255:0] mux_output;

always @(*)
begin
	case(sel)
		0: mux_output = in[0];
		1: mux_output = in[1];
		2: mux_output = in[2];
		// ... and so on for all 256 cases
	endcase
end

assign out = mux_output;

endmodule
