module top_module (
	input clk,
	input j,
	input k,
	output reg Q
);

	// Always block triggered on the rising edge of the clock signal.
	always @(posedge clk) begin
		if (j == 1'b0 && k == 1'b0) begin
			// No change in output
			Q <= Q;
		end
		else if (j == 1'b0 && k == 1'b1) begin
			// Reset the output
			Q <= 1'b0;
		end
		else if (j == 1'b1 && k == 1'b0) begin
			// Set the output
			Q <= 1'b1;
		end
		else if (j == 1'b1 && k == 1'b1) begin
			// Toggle the output
			Q <= ~Q;
		end
	end

endmodule
