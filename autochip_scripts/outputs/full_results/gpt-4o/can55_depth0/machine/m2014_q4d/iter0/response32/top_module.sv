module top_module (
	input clk,
	input in,
	output logic out
);
	// Initial value
	initial out = 0;

	always_ff @(posedge clk) begin
		out <= out ^ in;  // Toggle output on each clock edge
	end
endmodule
