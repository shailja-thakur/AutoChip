module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output reg walk_left,
	output reg walk_right
);

	// Define states
	parameter WL = 1'b0, WR = 1'b1;
	reg state, next_state;

	// State transition logic (combinational)
	always @(*) begin
		case (state)
			WL: next_state = bump_left ? WR : WL;
			WR: next_state = bump_right ? WL : WR;
			default: next_state = WL; // default state
		endcase
	end

	// State register (sequential)
	always @(posedge clk or posedge areset) begin
		if (areset) state <= WL;
		else state <= next_state;
	end

	// Output logic
	always @(*) begin
		case(state)
			WL: begin
				walk_left = 1;
				walk_right = 0;
			end
			WR: begin
				walk_left = 0;
				walk_right = 1;
			end
			default: begin
				walk_left = 0;
				walk_right = 0; // default should never happen
			end
		endcase
	end

endmodule
