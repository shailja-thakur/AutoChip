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
	// Define the states
	typedef enum logic [1:0] {
		WALK_LEFT,
		WALK_RIGHT,
		FALL,
		DIGGING
	} state_t;

	// Define the signals
	logic [1:0] state;
	logic [1:0] next_state;
	logic walk_left;
	logic walk_right;
	logic aaah;
	logic digging;

	// State assignment
	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= WALK_LEFT;
		end else begin
			state <= next_state;
		end
	end

	// State transition and output logic
	always_comb begin
		case (state)
			WALK_LEFT: begin
				if (bump_right && !bump_left) begin
					next_state = WALK_RIGHT;
				end else if ((bump_left || bump_right) && !ground) begin
					next_state = FALL;
				end else if (dig && ground) begin
					next_state = DIGGING;
				end else begin
					next_state = WALK_LEFT;
				end
			end
			WALK_RIGHT: begin
				if (bump_left && !bump_right) begin
					next_state = WALK_LEFT;
				end else if ((bump_left || bump_right) && !ground) begin
					next_state = FALL;
				end else if (dig && ground) begin
					next_state = DIGGING;
				end else begin
					next_state = WALK_RIGHT;
				end
			end
			FALL: begin
				if (ground) begin
					if (state == WALK_LEFT) begin
						next_state = WALK_LEFT;
					end else if (state == WALK_RIGHT) begin
						next_state = WALK_RIGHT;
					end else if (dig && ground) begin
						next_state = DIGGING;
					end
				end else begin
					next_state = FALL;
				end
			end
			DIGGING: begin
				if (!ground) begin
					next_state = FALL;
				end else if (!dig) begin
					if (state == WALK_LEFT) begin
						next_state = WALK_LEFT;
					end else if (state == WALK_RIGHT) begin
						next_state = WALK_RIGHT;
					end
				end else begin
					next_state = DIGGING;
				end
			end
			default: begin
				next_state = WALK_LEFT;
			end
		endcase
	end

	// Output assignments
	assign walk_left = (state == WALK_LEFT);
	assign walk_right = (state == WALK_RIGHT);
	assign aaah = (state == FALL);
	assign digging = (state == DIGGING);
endmodule
