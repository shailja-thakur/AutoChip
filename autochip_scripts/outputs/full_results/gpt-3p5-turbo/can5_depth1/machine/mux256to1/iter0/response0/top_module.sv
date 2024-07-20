module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);
	// Check if the selection vector is within the range of the input vector
	if (sel > 255) begin
		$display("Error: Selection vector out of range.");
		$finish;
	end

	// Select the bit from the input vector based on the selection vector
	assign out = in[sel];

endmodule
