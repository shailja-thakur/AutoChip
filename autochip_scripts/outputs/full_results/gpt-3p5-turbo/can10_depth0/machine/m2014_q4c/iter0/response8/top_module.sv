module top_module (
	input clk,
	input d,
	input r,
	output logic q
);

	// Internal signal to store the value of the data input
	logic internal_q;

	// Clock edge detection
	always @(posedge clk) begin
		if (r) begin
			// When reset is active, set the output to 0
			internal_q <= 0;
		end else begin
			// Otherwise, set the output to the data input
			internal_q <= d;
		end
	end

	// Assign the internal signal to the output
	assign q = internal_q;

endmodule
