module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	input dig,
	output walk_left,
	output walk_right,
	output aaah,
	output digging
);
	// Define states
	typedef enum logic [2:0] {
		WALKING_LEFT,
		WALKING_RIGHT,
		FALLING,
		DIGGING
	} state_type;

	// Define signals
	logic [2:0] state;
	logic [2:0] next_state;
	logic walk_left;
	logic walk_right;
	logic aaah;
	logic digging;

	// Define state transition logic
	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= WALKING_LEFT;
		end else begin
			state <= next_state;
		end
	end

	// Define state output logic
	always_comb begin
		case (state)
			WALKING_LEFT:
				begin
					if (bump_right) begin
						next_state = WALKING_RIGHT;
					end else if (ground) begin
						next_state = WALKING_LEFT;
					end else begin
						next_state = FALLING;
					end
					walk_left = 1;
					walk_right = 0;
					aaah = 0;
					digging = 0;
				end
			WALKING_RIGHT:
				begin
					if (bump_left) begin
						next_state = WALKING_LEFT;
					end else if (ground) begin
						next_state = WALKING_RIGHT;
					end else begin
						next_state = FALLING;
					end
					walk_left = 0;
					walk_right = 1;
					aaah = 0;
					digging = 0;
				end
			FALLING:
				begin
					if (ground) begin
						if (state == WALKING_LEFT) begin
							next_state = WALKING_LEFT;
						end else if (state == WALKING_RIGHT) begin
							next_state = WALKING_RIGHT;
						end else if (state == DIGGING) begin
							next_state = FALLING;
						end
					end else begin
						next_state = FALLING;
					end
					walk_left = 0;
					walk_right = 0;
					aaah = 1;
					digging = 0;
				end
			DIGGING:
				begin
					if (ground) begin
						next_state = WALKING_LEFT;
					end else begin
						next_state = DIGGING;
					end
					walk_left = 0;
					walk_right = 0;
					aaah = 0;
					digging = 1;
				end
		endcase
	end
endmodule
