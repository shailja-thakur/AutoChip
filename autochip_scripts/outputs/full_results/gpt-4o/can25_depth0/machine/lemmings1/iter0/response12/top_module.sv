module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output reg walk_left,
	output reg walk_right
);

	// State encoding
	localparam WL = 1'b0, WR = 1'b1;

	// State register
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

	// Sequential logic for state transition
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= WL;
		else
			state <= next_state;
	end

	// Output logic based on the state
	always @(*) begin
		walk_left = (state == WL);
		walk_right = (state == WR);
		end
endmodule
