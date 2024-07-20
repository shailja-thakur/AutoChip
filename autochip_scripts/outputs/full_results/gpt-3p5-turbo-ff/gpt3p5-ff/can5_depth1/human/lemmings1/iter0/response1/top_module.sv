module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);
	// Declare the state register
	reg [1:0] state;

	// Define the state encodings
	parameter WALK_LEFT = 2'b00;
	parameter WALK_RIGHT = 2'b01;

	// Define the next state logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= WALK_LEFT;
		end else begin
			if (bump_left && !bump_right) begin
				state <= WALK_RIGHT;
			end else if (!bump_left && bump_right) begin
				state <= WALK_LEFT;
			end else begin
				state <= state;
			end
		end
	end

	// Define the output logic
	always @(state, bump_left, bump_right) begin
		case (state)
			WALK_LEFT: begin
				walk_left = 1;
				walk_right = 0;
			end
			WALK_RIGHT: begin
				walk_left = 0;
				walk_right = 1;
			end
		endcase
	end
endmodule
