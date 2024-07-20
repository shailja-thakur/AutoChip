module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

reg [1:0] state, next_state;
wire current_state;

// Combinational always block to determine the next state
always @(*) begin
	if (state == 2'b00) begin // State A
		if (j)
			next_state = 2'b01; // State B
		else
			next_state = 2'b00; // Stay in State A
	end else begin // State B
		if (k)
			next_state = 2'b00; // State A
		else
			next_state = 2'b01; // Stay in State B
	end
end

// Clocked always block to update the state
always @(posedge clk or posedge areset) begin
	if (areset)
		state <= 2'b00; // Reset state to A
	else
		state <= next_state; // Update state based on next state
end

// Assign current_state based on current state
assign current_state = (state == 2'b01) ? 1'b1 : 1'b0;

// Assign out port based on current state
assign out = current_state;

endmodule
