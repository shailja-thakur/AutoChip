module top_module (
	input clk,
	input in,
	output logic out
);

	// Declare internal register to hold the state
	logic current_state;

	// Initial block to set the initial state of output
	initial begin
		current_state = 0;
		out = 0;
	end

	// Always block to update the state on the positive edge of the clock
	always_ff @(posedge clk) begin
		current_state <= current_state ^ in;
		out <= current_state;
	end

endmodule
