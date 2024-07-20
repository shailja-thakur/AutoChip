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
	typedef enum logic [1:0] {
		WALK_LEFT,
		WALK_RIGHT,
		FALL,
		DIG,
		SPLATTER
	} state_t;

	// Define local signals and variables
	reg [4:0] count;
	reg [1:0] state, next_state;

	// Initialize signals and variables
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			count <= 0;
			state <= WALK_LEFT;
		end else begin
			count <= count + 1;
			state <= next_state;
		end
	end

	// Update next state and outputs based on current state and inputs
	always @* begin
		next_state = state;
		walk_left = 0;
		walk_right = 0;
		aaah = 0;
		digging = 0;

		case (state)
			WALK_LEFT:
				if (bump_right) begin
					next_state = WALK_RIGHT;
					walk_right = 1;
				end else if (!ground) begin
					next_state = FALL;
					aaah = 1;
				end else if (dig && ground) begin
					next_state = DIG;
					digging = 1;
				end
			WALK_RIGHT:
				if (bump_left) begin
					next_state = WALK_LEFT;
					walk_left = 1;
				end else if (!ground) begin
					next_state = FALL;
					aaah = 1;
				end else if (dig && ground) begin
					next_state = DIG;
					digging = 1;
				end
			FALL:
				if (ground) begin
					next_state = walk_left ? WALK_LEFT : WALK_RIGHT;
				end else if (count >= 20) begin
					next_state = SPLATTER;
				end
			DIG:
				if (!ground) begin
					next_state = FALL;
					aaah = 1;
				end
			SPLATTER:
				next_state = SPLATTER;
		endcase
	end
endmodule
