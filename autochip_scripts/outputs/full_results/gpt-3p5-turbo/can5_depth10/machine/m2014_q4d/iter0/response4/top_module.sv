module top_module (
	input clk,
	input in,
	output logic out
);

	// internal signal to hold the previous value of out
	logic prev_out;

	always @(posedge clk)
	begin
		// toggle out based on the current and previous values
		out <= in ^ prev_out;
		// update prev_out with the current value
		prev_out <= out;
	end

endmodule
