module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	output walk_left,
	output walk_right,
	output aaah
);

	// Define states
	typedef enum logic [1:0] {
		WALK_LEFT,
		WALK_RIGHT,
		FALL
	} state_t;

	// Define current state variable
	state_t current_state;

	// Define next state variable
	state_t next_state;

	// Define outputs
	logic walk_left;
	logic walk_right;
	logic aaah;

	// Define internal signals
	logic bump_left_internal;
	logic bump_right_internal;

	// Assign internal signals
	assign bump_left_internal = (areset) ? 0 : bump_left;
	assign bump_right_internal = (areset) ? 0 : bump_right;

	// Register next state and current state
	always_ff @(posedge clk, posedge areset) begin
		if (areset) begin
			current_state <= WALK_LEFT;
		end else begin
			current_state <= next_state;
		end
	end

	// Define output logic
	always_comb begin
		case (current_state)
			WALK_LEFT: begin
				walk_left = 1;
				walk_right = 0;
				aaah = 0;
				if (bump_right_internal) begin
					next_state = WALK_RIGHT;
				end else if (!ground) begin
					next_state = FALL;
				end else begin
					next_state = WALK_LEFT;
				end
			end

			WALK_RIGHT: begin
				walk_left = 0;
				walk_right = 1;
				aaah = 0;
				if (bump_left_internal) begin
					next_state = WALK_LEFT;
				end else if (!ground) begin
					next_state = FALL;
				end else begin
					next_state = WALK_RIGHT;
				end
			end

			FALL: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 1;
				if (ground) begin
					if (walk_left) begin
						next_state = WALK_LEFT;
					end else begin
						next_state = WALK_RIGHT;
					end
				end else begin
					next_state = FALL;
				end
			end
		endcase
	end

endmodule
