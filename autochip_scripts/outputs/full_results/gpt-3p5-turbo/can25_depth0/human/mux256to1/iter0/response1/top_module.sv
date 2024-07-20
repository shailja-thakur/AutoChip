module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

// Create an 8-to-1 multiplexer for each bit of in
wire [7:0] mux_out;
genvar i;
generate
for (i = 0; i < 8; i = i + 1) begin: mux_gen
    assign mux_out[i] = in[(8*i) +: 8];
end
endgenerate

// Create a 256-to-1 multiplexer for the mux_out bits
assign out = mux_out[sel];

endmodule
