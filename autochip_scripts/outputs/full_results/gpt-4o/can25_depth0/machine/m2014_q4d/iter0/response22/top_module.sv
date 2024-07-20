module top_module (
	input clk,
	input in,
	output logic out
);

	// Initialize output to 0
	initial begin
		out = 0;
	end

	// Always block to handle clock edge
	always_ff @(posedge clk) begin
		out <= out ^ in;
	end

endmodule
