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

reg walk_left;
reg walk_right;
reg aaah;
reg digging;
reg [4:0] fall_timer;
reg [1:0] state;
reg [1:0] next_state;

// Define state constants
parameter WALK_LEFT = 2'b00;
parameter WALK_RIGHT = 2'b01;
parameter FALL = 2'b10;
parameter DIG = 2'b11;

// Define state transition and output logic
always @(posedge clk or posedge areset) begin
	if (areset) begin
		walk_left <= 1'b1;
		walk_right <= 1'b0;
		aaah <= 1'b0;
		digging <= 1'b0;
		fall_timer <= 5'b0;
		state <= WALK_LEFT;
	end else begin
		state <= next_state;
		case (state)
			WALK_LEFT:
				begin
					walk_left <= 1'b1;
					walk_right <= 1'b0;
					if (bump_right)
						next_state <= WALK_RIGHT;
					else if (ground && !fall_timer[4])
						next_state <= WALK_LEFT;
					else if (!ground)
						next_state <= FALL;
					else if (dig && ground)
						next_state <= DIG;
					else
						next_state <= WALK_LEFT;
				end
			WALK_RIGHT:
				begin
					walk_left <= 1'b0;
					walk_right <= 1'b1;
					if (bump_left)
						next_state <= WALK_LEFT;
					else if (ground && !fall_timer[4])
						next_state <= WALK_RIGHT;
					else if (!ground)
						next_state <= FALL;
					else if (dig && ground)
						next_state <= DIG;
					else
						next_state <= WALK_RIGHT;
				end
			FALL:
				begin
					walk_left <= 1'b0;
					walk_right <= 1'b0;
					if (ground) begin
						next_state <= state;
						if (fall_timer[4])
							aaah <= 1'b1;
						else
							aaah <= 1'b0;
						fall_timer <= 5'b0;
					end
					else if (fall_timer[4])
						next_state <= WALK_LEFT;
					else
						next_state <= FALL;
					fall_timer <= fall_timer + 1;
				end
			DIG:
				begin
					walk_left <= 1'b0;
					walk_right <= 1'b0;
					if (!ground || fall_timer[4])
						next_state <= state;
					else if (!ground && fall_timer[4])
						next_state <= FALL;
					else
						next_state <= DIG;
					digging <= 1'b1;
				end
		endcase
	end
end

endmodule
