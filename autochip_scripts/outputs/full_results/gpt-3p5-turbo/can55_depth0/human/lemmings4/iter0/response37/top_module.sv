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
	
	reg [20:0] fall_timer;
	reg [1:0] state;
	
	// State encoding
	parameter WALK_LEFT = 2'b00;
	parameter WALK_RIGHT = 2'b01;
	parameter FALLING = 2'b10;
	parameter DIGGING = 2'b11;

	// Output assignments
	always @(state) begin
		case (state)
			WALK_LEFT:
				walk_left = 1;
				walk_right = 0;
				aaah = 0;
				digging = 0;
			WALK_RIGHT:
				walk_left = 0;
				walk_right = 1;
				aaah = 0;
				digging = 0;
			FALLING:
				walk_left = 0;
				walk_right = 0;
				aaah = 1;
				digging = 0;
			DIGGING:
				walk_left = 0;
				walk_right = 0;
				aaah = 0;
				digging = 1;
		endcase
	end

	// State transitions
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= WALK_LEFT;
			fall_timer <= 0;
		end else begin
			case (state)
				WALK_LEFT:
					if (bump_right)
						state <= WALK_RIGHT;
					else if (!ground)
						state <= FALLING;
					else if (dig)
						state <= DIGGING;
				WALK_RIGHT:
					if (bump_left)
						state <= WALK_LEFT;
					else if (!ground)
						state <= FALLING;
					else if (dig)
						state <= DIGGING;
				FALLING:
					if (ground)
						state <= WALK_LEFT;
					else if (fall_timer >= 20)
						state <= FALLING;
				DIGGING:
					if (!ground)
						state <= FALLING;
					else if (dig)
						state <= DIGGING;
			endcase
		end
	end

	// Fall timer increment
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			fall_timer <= 0;
		end else begin
			if (state == FALLING) begin
				if (ground)
					fall_timer <= 0;
				else if (fall_timer == 20)
					fall_timer <= 0;
				else
					fall_timer <= fall_timer + 1;
			end else begin
				fall_timer <= 0;
			end
		end
	end

endmodule
