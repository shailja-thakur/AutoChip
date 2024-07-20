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

	reg [3:0] state, next_state;
	reg [4:0] fall_count;

	// State encoding
	localparam WALK_LEFT = 4'b0001, 
	           WALK_RIGHT = 4'b0010,
	           FALL_LEFT = 4'b0100,
	           FALL_RIGHT = 4'b1000,
	           DIG_LEFT = 4'b0001 | 4'b0010,
	           DIG_RIGHT = 4'b0010 | 4'b0100,
	           SPLAT = 4'b0000;

	// State transition
	always @(*) begin
		case (state)
			WALK_LEFT: begin
				if (!ground)
					next_state = FALL_LEFT;
				else if (dig)
					next_state = DIG_LEFT;
				else if (bump_left)
					next_state = WALK_RIGHT;
				else
					next_state = WALK_LEFT;
			end
			WALK_RIGHT: begin
				if (!ground)
					next_state = FALL_RIGHT;
				else if (dig)
					next_state = DIG_RIGHT;
				else if (bump_right)
					next_state = WALK_LEFT;
				else
					next_state = WALK_RIGHT;
			end
			FALL_LEFT: begin
				if (fall_count >= 20)
					next_state = SPLAT;
				else if (ground)
					next_state = WALK_LEFT;
				else
					next_state = FALL_LEFT;
			end
			FALL_RIGHT: begin
				if (fall_count >= 20)
					next_state = SPLAT;
				else if (ground)
					next_state = WALK_RIGHT;
				else
					next_state = FALL_RIGHT;
			end
			DIG_LEFT: begin
				if (!ground)
					next_state = FALL_LEFT;
				else
					next_state = DIG_LEFT;
			end
			DIG_RIGHT: begin
				if (!ground)
					next_state = FALL_RIGHT;
				else
					next_state = DIG_RIGHT;
			end
			SPLAT: begin
				next_state = SPLAT;
			end
			default: begin
				next_state = WALK_LEFT;
			end
		endcase
	end

	// State register
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= WALK_LEFT;
			fall_count <= 5'b0;
		end else begin
			if (state == FALL_LEFT || state == FALL_RIGHT) begin
				if (!ground)
					fall_count <= fall_count + 1;
				else
					fall_count <= 5'b0;
			end else 
				fall_count <= 5'b0;
			state <= next_state;
		end
	end

	// Output logic
	always @(*) begin
		walk_left = 0;
		walk_right = 0;
		aaah = 0;
		digging = 0;
		case (state)
			WALK_LEFT: begin
				walk_left = 1;
			end
			WALK_RIGHT: begin
				walk_right = 1;
			end
			FALL_LEFT: begin
				aaah = 1;
			end
			FALL_RIGHT: begin
				aaah = 1;
			end
			DIG_LEFT: begin
				digging = 1;
			end
			DIG_RIGHT: begin
				digging = 1;
			end
			SPLAT: begin
				walk_left = 0;
				walk_right = 0;
				aaah = 0;
				digging = 0;
			end
		endcase
	end

endmodule
