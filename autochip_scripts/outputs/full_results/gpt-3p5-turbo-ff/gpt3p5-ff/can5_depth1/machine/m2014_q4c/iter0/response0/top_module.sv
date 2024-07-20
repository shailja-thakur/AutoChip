module top_module (
	input clk,
	input d,
	input r,
	output logic q
);

	// Declare an internal register variable
	reg logic q_reg;

	// Always block triggered by rising edge of the clock
	always_ff @(posedge clk) begin
		// Check if reset is active
		if (r) begin
			// Reset the register output to 0
			q_reg <= 0;
		end else begin
			// Store the data input in the register
			q_reg <= d;
		end
	end

	// Assign the output of the register to the output port q
	assign q = q_reg;

endmodule
