module top_module (
	input clk,
	input in,
	output logic out
);

	// Initialize output to 0
	initial out = 0;

	always_ff @(posedge clk) begin
		out <= out ^ in;
	end
	
endmodule
