module top_module (
	input clk,
	input d,
	input r,
	output logic q
);

	// Define internal register
	reg logic q_reg;

	// Register logic
	always_ff @(posedge clk)
	begin
		if (r)
			q_reg <= 0;
		else
			q_reg <= d;
	end
	
	// Assign output
	assign q = q_reg;

endmodule
