module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

wire [255:0] sel_out;

// Split the input vector into 256 4-bit inputs
generate
	genvar i;
	for (i = 0; i < 256; i = i + 1) begin: split_inputs
		assign sel_out[i] = in[(i*4) +: 4];
	end
endgenerate

// Create 256-to-1 multiplexer
assign out = sel_out[sel];

endmodule
