module top_module (
	input clk,
	input in,
	output logic out
);

	// Internal signal to hold the previous output value
	logic prev_out;

	// Assign initial values
	assign out = prev_out;

	// Always block to update the output value
	always_ff @(posedge clk)
	begin
		// XOR the input and previous output value to get the new output value 
		out <= in ^ prev_out;
		// Update the previous output value with the new output value
		prev_out <= out;
	end

endmodule
