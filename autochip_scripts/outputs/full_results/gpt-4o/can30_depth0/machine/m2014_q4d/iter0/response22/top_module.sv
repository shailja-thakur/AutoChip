module top_module (
	input clk,
	input in,
	output logic out
);

	// Initial state of output is set to 0
	initial begin
		out = 0;
	end

	always_ff @(posedge clk) begin
		out <= out ^ in;
	end

endmodule
