module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	output reg walk_left,
	output reg walk_right,
	output reg aaah
);

	// Define the states
	typedef enum logic [1:0] {
		IDLE,
		WALK_LEFT,
		WALK_RIGHT,
		FALL
	} state_t;

	// Define the current state
	reg state_t current_state;

	// Synchronous always block to handle state transitions
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= IDLE;
		end else begin
			case (current_state)
				IDLE: begin
					if (bump_left && bump_right) begin
						current_state <= WALK_RIGHT;
					end else if (bump_left) begin
						current_state <= WALK_RIGHT;
					end else if (bump_right) begin
						current_state <= WALK_LEFT;
					end else begin
						current_state <= IDLE;
					end
				end
				WALK_LEFT: begin
					if (bump_left && bump_right) begin
						current_state <= WALK_RIGHT;
					end else if (bump_left) begin
						current_state <= WALK_RIGHT;
					end else if (bump_right) begin
						current_state <= WALK_LEFT;
					end else if (!ground) begin
						current_state <= FALL;
					end else begin
						current_state <= WALK_LEFT;
					end
				end
				WALK_RIGHT: begin
					if (bump_left && bump_right) begin
						current_state <= WALK_LEFT;
					end else if (bump_left) begin
						current_state <= WALK_RIGHT;
					end else if (bump_right) begin
						current_state <= WALK_LEFT;
					end else if (!ground) begin
						current_state <= FALL;
					end else begin
						current_state <= WALK_RIGHT;
					end
				end
				FALL: begin
					if (ground) begin
						if (current_state == WALK_LEFT) begin
							current_state <= WALK_LEFT;
						end else if (current_state == WALK_RIGHT) begin
							current_state <= WALK_RIGHT;
						end else begin
							current_state <= IDLE;
						end
					end else begin
						current_state <= FALL;
					end
				end
			endcase
		end
	end

	// Combinational logic to drive outputs
	always @(current_state) begin
		case (current_state)
			IDLE: begin
				walk_left <= 1'b1;
				walk_right <= 1'b0;
				aaah <= 1'b0;
			end
			WALK_LEFT: begin
				walk_left <= 1'b1;
				walk_right <= 1'b0;
				aaah <= 1'b0;
			end
			WALK_RIGHT: begin
				walk_left <= 1'b0;
				walk_right <= 1'b1;
				aaah <= 1'b0;
			end
			FALL: begin
				walk_left <= 1'b0;
				walk_right <= 1'b0;
				aaah <= 1'b1;
			end
			default: begin
				walk_left <= 1'b0;
				walk_right <= 1'b0;
				aaah <= 1'b0;
			end
		endcase
	end

endmodule
