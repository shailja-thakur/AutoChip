module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

reg [1:0] state, next_state; // Define state and next_state as 2-bit registers

always @* begin
	// Determine the next state based on the current state and the values of j and k
	if (state == 2'b00) begin
		// If current state is A, next state is determined by j
		if (j)
			next_state = 2'b01; // Next state is B if j is high
		else
			next_state = 2'b00; // Next state is A if j is low
	end
	else begin
		// If current state is B, next state is determined by k
		if (k)
			next_state = 2'b00; // Next state is A if k is high
		else
			next_state = 2'b01; // Next state is B if k is low
	end
end

always @(posedge clk) begin
	// Update the state based on the value of areset and the value of next_state
	if (areset)
		state <= 2'b00; // Reset the state to A if areset is high
	else
		state <= next_state; // Update the state to the next_state value
end

assign out = (state == 2'b01) ? 1'b1 : 1'b0; // Set out to high if state is B, otherwise low

endmodule
