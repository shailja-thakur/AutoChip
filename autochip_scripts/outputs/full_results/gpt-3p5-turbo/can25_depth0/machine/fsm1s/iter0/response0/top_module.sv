module top_module (
	input clk,
	input in,
	input reset,
	output out
);

parameter A = 1'b0; // Define state A as low
parameter B = 1'b1; // Define state B as high

reg state; // Parameterized register to store current state

always @(posedge clk) begin
	if (reset)
		state <= B; // Reset state to initial state B
	else if (state == A) begin
		if (in)
			state <= A; // Stay in state A if input is high
		else
			state <= B; // Transition to state B if input is low
	end else begin
		if (in)
			state <= B; // Stay in state B if input is high
		else
			state <= A; // Transition to state A if input is low
	end
end

assign out = state; // Assign current state to output

endmodule
