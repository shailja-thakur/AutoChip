module top_module (
	input clk,
	input d,
	input r,
	output logic q
);

	// define register variable
	logic reg q_reg;

	// always block triggered on the rising edge of the clock
	always_ff @(posedge clk) begin
		// check if reset is active
		if (r) begin
			// if reset is active, set q_reg to 0
			q_reg <= 0;
		end else begin
			// if reset is not active, set q_reg to the value of d
			q_reg <= d;
		end
	end

	// assign q to q_reg
	assign q = q_reg;

endmodule
