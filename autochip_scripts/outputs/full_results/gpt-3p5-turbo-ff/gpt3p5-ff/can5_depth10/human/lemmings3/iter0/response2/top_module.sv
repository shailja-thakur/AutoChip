module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	input dig,
	output reg walk_left,
	output reg walk_right,
	output reg aaah,
	output reg digging
);

	// Define states
	typedef enum logic [2:0] {
		WALK_LEFT,
		WALK_RIGHT,
		FALL,
		DIG
	} state_t;

	// Define signals
	reg [2:0] state;
	reg [2:0] next_state;
	reg [2:0] default_next_state;

	// Define state outputs
	assign walk_left = (state == WALK_LEFT);
	assign walk_right = (state == WALK_RIGHT);
	assign aaah = (state == FALL);
	assign digging = (state == DIG);

	// Assign default next state
	always_comb begin
		default_next_state = state;
	end

	// Define state transitions and outputs
	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= WALK_LEFT;
		end else begin
			state <= next_state;
		end
	end

	// Define state transitions
	always_comb begin
		case (state)
			WALK_LEFT:
				begin
					if (bump_right && !bump_left) begin
						next_state = WALK_RIGHT;
					end else if (!ground) begin
						next_state = FALL;
					end else if (dig) begin
						next_state = DIG;
					end else begin
						next_state = WALK_LEFT;
					end
				end
			WALK_RIGHT:
				begin
					if (!bump_right && bump_left) begin
						next_state = WALK_LEFT;
					end else if (!ground) begin
						next_state = FALL;
					end else if (dig) begin
						next_state = DIG;
					end else begin
						next_state = WALK_RIGHT;
					end
				end
			FALL:
				begin
					if (ground) begin
						next_state = default_next_state;
					end else begin
						next_state = FALL;
					end
				end
			DIG:
				begin
					if (!ground) begin
						next_state = FALL;
					end else if (!dig) begin
						next_state = default_next_state;
					end else begin
						next_state = DIG;
					end
				end
			default:
				begin
					next_state = default_next_state;
				end
		endcase
	end
endmodule
