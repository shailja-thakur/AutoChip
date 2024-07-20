module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

	// Define a wire to hold the selected bit
	wire selected_bit;
	
	// Instantiate a MUX module to select the bit from the input vector
	mux_module mux(
		.in(in[sel]),
		.sel(sel),
		.out(selected_bit)
	);
	
	// Assign the selected bit to the output
	assign out = selected_bit;
	
endmodule
module mux_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);
	reg [255:0] selected_bit;
	
	always @(in or sel) begin
		selected_bit = in[sel];
	end
	
	assign out = selected_bit;
	
endmodule
