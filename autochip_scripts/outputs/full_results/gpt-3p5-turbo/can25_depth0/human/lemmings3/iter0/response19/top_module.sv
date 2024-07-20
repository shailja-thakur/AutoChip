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

	localparam STATE_WALK_LEFT = 2'b00;
	localparam STATE_WALK_RIGHT = 2'b01;
	localparam STATE_FALL = 2'b10;
	localparam STATE_DIG = 2'b11;

	reg [1:0] state;
	reg [1:0] next_state;

	initial begin
		state = STATE_WALK_LEFT;
		next_state = STATE_WALK_LEFT;
		walk_left = 1;
		walk_right = 0;
		aaah = 0;
		digging = 0;
	end

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= STATE_WALK_LEFT;
			next_state <= STATE_WALK_LEFT;
			walk_left <= 1;
			walk_right <= 0;
			aaah <= 0;
			digging <= 0;
		end else begin
			state <= next_state;
			case (state)
				STATE_WALK_LEFT:
					if (bump_right)
						next_state = STATE_WALK_RIGHT;
					else if (!ground)
						next_state = STATE_FALL;
					else if (dig && ground)
						next_state = STATE_DIG;
					else
						next_state = STATE_WALK_LEFT;
				STATE_WALK_RIGHT:
					if (bump_left)
						next_state = STATE_WALK_LEFT;
					else if (!ground)
						next_state = STATE_FALL;
					else if (dig && ground)
						next_state = STATE_DIG;
					else
						next_state = STATE_WALK_RIGHT;
				STATE_FALL:
					if (dig && ground)
						next_state = STATE_DIG;
					else if (ground)
						next_state = state;
					else
						next_state = STATE_FALL;
				STATE_DIG:
					if (!ground)
						next_state = STATE_FALL;
					else if (digging)
						next_state = state;
					else
						next_state = STATE_WALK_LEFT;
				default:
					next_state = STATE_WALK_LEFT;
			endcase
		end
	end

	always @(state) begin
		case (state)
			STATE_WALK_LEFT:
				walk_left = 1;
				walk_right = 0;
				aaah = 0;
				digging = 0;
			STATE_WALK_RIGHT:
				walk_left = 0;
				walk_right = 1;
				aaah = 0;
				digging = 0;
			STATE_FALL:
				walk_left = 0;
				walk_right = 0;
				aaah = 1;
				digging = 0;
			STATE_DIG:
				walk_left = 0;
				walk_right = 0;
				aaah = 0;
				digging = 1;
			default:
				walk_left = 0;
				walk_right = 0;
				aaah = 0;
				digging = 0;
		endcase
	end

endmodule
