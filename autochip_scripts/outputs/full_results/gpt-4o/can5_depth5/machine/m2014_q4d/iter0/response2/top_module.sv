module top_module (
	input clk,
	input in,
	output logic out
);

	// Initial state
	initial begin
		out = 0;
	end

	// Always block triggered on the positive edge of the clock signal
	always_ff @(posedge clk) begin
		out <= out ^ in;  // Toggle the output on clock edge based on input
	end

endmodule
