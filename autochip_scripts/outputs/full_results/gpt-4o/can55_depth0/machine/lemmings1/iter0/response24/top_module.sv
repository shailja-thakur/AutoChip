module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output reg walk_left,
	output reg walk_right
);
	// Parameters defining the states
	parameter WL = 1'b0, WR = 1'b1;

	// Register to hold the current state
	reg state, next_state;

	// Combinational logic to determine the next state
	always @(*) begin
		case (state)
			WL: begin
				if (bump_left)
					next_state = WR;
				else
					next_state = WL;
			end
			WR: begin
				if (bump_right)
					next_state = WL;
				else
					next_state = WR;
			end
			default: next_state = WL;
		endcase
	end

	// Sequential logic to update the state on the rising edge of the clock
	// and reset to the initial state on the rising edge of areset
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= WL;
		else
			state <= next_state;
		end
	
	// Assignments for the output signals based on the current state
	always @(*) begin
		case (state)
			WL: begin
				walk_left = 1;
				walk_right = 0;
			end
			WR: begin
				walk_left = 0;
				walk_right = 1;
			end
		endcase
	end
	
endmodule
