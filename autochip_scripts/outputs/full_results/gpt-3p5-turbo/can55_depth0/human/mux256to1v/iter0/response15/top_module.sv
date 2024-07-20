module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

wire [255:0] in_mux;

assign in_mux[0] = in[3:0];
assign in_mux[1] = in[7:4];
assign in_mux[2] = in[11:8];
// Repeat this pattern for all 256 input selections

assign out = in_mux[sel];

endmodule
