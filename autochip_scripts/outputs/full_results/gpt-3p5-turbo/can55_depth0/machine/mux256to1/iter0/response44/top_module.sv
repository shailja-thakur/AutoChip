module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);
	// Declare wire for storing the selected bit
	wire selected_bit;
	
	// Always block to select the bit from the input vector based on the selection vector
	always @* begin
		selected_bit = in[sel];
	end
	
	// Assign the selected bit to the output
	assign out = selected_bit;
endmodule
