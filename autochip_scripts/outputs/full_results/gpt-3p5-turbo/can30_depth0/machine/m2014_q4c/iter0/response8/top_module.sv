module top_module (
	input clk,
	input d,
	input r,
	output logic q
);

	// Internal register to store the data
	logic reg_data;

	// Process triggered on rising edge of the clock
	always_ff @(posedge clk) begin
		// Reset the register if the reset signal is active
		if (r)
			reg_data <= 0;
		// Otherwise, store the data input in the register
		else
			reg_data <= d;
	end

	// Assign the output of the register to the output port
	assign q = reg_data;

endmodule
