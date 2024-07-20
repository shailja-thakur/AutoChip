module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);
	// Define the states
	parameter A = 1'b0;
	parameter B = 1'b1;

	// Define the next state based on current state and inputs
	reg state, next_state;
	always @* begin
		if (state == A)
			next_state = j ? B : A;
		else if (state == B)
			next_state = k ? A : B;
	end

	// Update the state based on areset and next state
	always @(posedge clk) begin
		if (areset)
			state <= A;
		else
			state <= next_state;
	end

	// Output the current state
	assign out = (state == B) ? 1'b1 : 1'b0;
endmodule
