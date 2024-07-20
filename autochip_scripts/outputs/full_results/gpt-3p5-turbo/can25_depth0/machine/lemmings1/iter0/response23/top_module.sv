module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output reg walk_left,
	output reg walk_right
);

parameter WL = 0;
parameter WR = 1;

reg [1:0] state; // Register to hold the current state of the state machine

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= WL; // Reset the state to the initial state
	else begin  
		// Update the state based on the current state and input signals
		if (state == WL) begin
			if (bump_left)
				state <= WR;
			else
				state <= WL;
		end else begin // state == WR
			if (bump_right)
				state <= WL;
			else
				state <= WR;
		end
	end
end

always @(posedge clk) begin
	// Assign the outputs based on the current state of the state machine
	if (state == WL) begin
		walk_left <= 1;
		walk_right <= 0;
	end else begin // state == WR
		walk_left <= 0;
		walk_right <= 1;
	end
end

endmodule
