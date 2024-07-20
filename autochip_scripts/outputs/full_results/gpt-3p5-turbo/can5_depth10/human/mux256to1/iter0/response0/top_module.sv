module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);
	// Create a 1-bit wide, 256-to-1 multiplexer

	// Calculate the index for the selected input
	reg [7:0] index;
	always @* begin
		index = sel;
	end
	
	// Select the corresponding input using the calculated index
	assign out = in[index];

endmodule
