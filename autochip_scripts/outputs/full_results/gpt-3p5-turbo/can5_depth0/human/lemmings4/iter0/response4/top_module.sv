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

	// Define state encoding
	typedef enum logic [2:0] {
		WALK_LEFT,
		WALK_RIGHT,
		FALL,
		DIG,
		SPLATTER
	} state_e;
	
	// Declare local variables
	reg [2:0] state;
	reg [4:0] fall_counter;
	reg [4:0] dig_counter;
	
	// State register
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= WALK_LEFT;
			fall_counter <= 0;
			dig_counter <= 0;
		end else begin
			case (state)
				WALK_LEFT:
					if (bump_right && !bump_left)
						state <= WALK_RIGHT;
					else if (bump_right && bump_left)
						state <= WALK_RIGHT;
					else if (!bump_right && bump_left)
						state <= WALK_LEFT;
					else if (ground == 0)
						state <= FALL;
					else if (dig == 1 && ground == 1)
						state <= DIG;
				WALK_RIGHT:
					if (bump_right && !bump_left)
						state <= WALK_RIGHT;
					else if (bump_right && bump_left)
						state <= WALK_LEFT;
					else if (!bump_right && bump_left)
						state <= WALK_LEFT;
					else if (ground == 0)
						state <= FALL;
					else if (dig == 1 && ground == 1)
						state <= DIG;
				FALL:
					if (ground == 1)
						if (fall_counter > 20)
							state <= SPLATTER;
						else
							state <= state;
					else
						state <= FALL;
				DIG:
					if (ground == 0)
						state <= FALL;
					else if (dig_counter > 20)
						state <= SPLATTER;
					else
						state <= state;
				SPLATTER:
					state <= SPLATTER;
				default:
					state <= WALK_LEFT;
			endcase
		end
	end
	
	// Output logic
	always @(state or ground) begin
		walk_left = (state == WALK_LEFT) ? 1'b1 : 1'b0;
		walk_right = (state == WALK_RIGHT) ? 1'b1 : 1'b0;
		aaah = (state == FALL || state == SPLATTER) ? 1'b1 : 1'b0;
		digging = (state == DIG) ? 1'b1 : 1'b0;
	end
	
endmodule
