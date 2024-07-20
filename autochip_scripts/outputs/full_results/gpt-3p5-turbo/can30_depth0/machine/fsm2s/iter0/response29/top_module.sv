module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

	// Declare internal state signal
	reg state;

	// Initialize state to A
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 0;
		end else begin
			// Determine next state based on current state and inputs j and k
			if (state == 0) begin
				state <= j ? 1 : 0;
			end else begin
				state <= k ? 0 : 1;
			end
		end
	end

	// Assign output based on current state
	assign out = (state == 1) ? 1'b1 : 1'b0;

endmodule
