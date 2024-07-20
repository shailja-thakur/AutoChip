module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

	// This module uses a multiplexer to select the bit from the input vector based on the selection vector
	// The selected bit is assigned to the output
	
	reg selected_bit;
	
	always @(*) begin
		selected_bit = in[sel];
	end
	
	assign out = selected_bit;
	
endmodule
