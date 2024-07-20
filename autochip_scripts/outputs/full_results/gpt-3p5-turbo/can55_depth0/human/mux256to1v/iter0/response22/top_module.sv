module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

wire [3:0] mux_out;

assign out = mux_out;

// Create the 256-to-1 multiplexer
genvar i;
generate
	for (i = 0; i < 256; i = i + 1) begin : mux_instance
		// Calculate the starting index of each 4-bit input
		wire [9:0] start_index = i * 4 + sel * 4;
		// Extract the corresponding 4-bit input from the input vector
		wire [3:0] mux_input = in[start_index +: 4];
		// Connect the multiplexer inputs to the outputs
		if (i == 0) begin : first_input
			mux4to1 mux (
				.in(mux_input),
				.sel(sel),
				.out(mux_out)
			);
		end
		else begin
			mux4to1 mux (
				.in(mux_input),
				.sel(sel),
				.out()
			);
		end
	end
endgenerate

endmodule
module mux4to1 (
	input [3:0] in,
	input [7:0] sel,
	output [3:0] out
);
	assign out = in[sel];
endmodule
