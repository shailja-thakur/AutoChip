module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	// Declare the state variable
	reg state;

	// Synchronous process for state update
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 0; // Reset state to B
		end else begin
			// State transitions based on current state and input
			if (state == 0) begin // State A
				if (in) begin
					state <= 0; // Next state A
				end else begin
					state <= 1; // Next state B
				end
			end else begin // State B
				if (in) begin
					state <= 1; // Next state B
				end else begin
					state <= 0; // Next state A
				end
			end
		end
	end

	// Assign output based on state
	assign out = (state == 1) ? 1'b1 : 1'b0;
endmodule
