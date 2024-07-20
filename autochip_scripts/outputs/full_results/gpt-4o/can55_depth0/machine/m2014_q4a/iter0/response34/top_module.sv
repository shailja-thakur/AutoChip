module top_module (
	input d,
	input ena,
	output logic q
);

	// Internal register to hold output state
	logic q_reg;

	// Always block to handle enable logic
	always_comb begin
		// If enable is high, output follows input
		if (ena)
			q_reg = d;
		// If enable is low, output remains unchanged
	end
	
	// Assign the internal register to the output port
	assign q = q_reg;

endmodule
