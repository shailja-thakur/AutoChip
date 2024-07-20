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

// State definition
parameter WALK_LEFT = 2'b00;
parameter WALK_RIGHT = 2'b01;
parameter FALL = 2'b10;
parameter DIGGING = 2'b11;

// State register
reg [1:0] state;

// Output register
reg walk_left_reg;
reg walk_right_reg;
reg aaah_reg;
reg digging_reg;

// Counter for tracking fall duration
reg [4:0] fall_counter;

// Initial state
initial begin
	state = WALK_LEFT;
	walk_left_reg = 1;
	walk_right_reg = 0;
	aaah_reg = 0;
	digging_reg = 0;
	fall_counter = 0;
end

// State machine
always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= WALK_LEFT;
		walk_left_reg <= 1;
		walk_right_reg <= 0;
		aaah_reg <= 0;
		digging_reg <= 0;
		fall_counter <= 0;
	end else begin
		case (state)
			WALK_LEFT:
				if (bump_right) begin
					state <= WALK_RIGHT;
					walk_left_reg <= 0;
					walk_right_reg <= 1;
				end else if (dig && ground) begin
					state <= DIGGING;
					walk_left_reg <= 0;
					walk_right_reg <= 0;
					digging_reg <= 1;
				end else if (fall_counter >= 20 && ground) begin
					state <= FALL;
					walk_left_reg <= 0;
					walk_right_reg <= 0;
					aaah_reg <= 1;
				end
			WALK_RIGHT:
				if (bump_left) begin
					state <= WALK_LEFT;
					walk_left_reg <= 1;
					walk_right_reg <= 0;
				end else if (dig && ground) begin
					state <= DIGGING;
					walk_left_reg <= 0;
					walk_right_reg <= 0;
					digging_reg <= 1;
				end else if (fall_counter >= 20 && ground) begin
					state <= FALL;
					walk_left_reg <= 0;
					walk_right_reg <= 0;
					aaah_reg <= 1;
				end
			FALL:
				if (ground) begin
					state <= WALK_LEFT;
					walk_left_reg <= 1;
					walk_right_reg <= 0;
					aaah_reg <= 0;
					fall_counter <= 0;
				end
			DIGGING:
				if (!ground) begin
					state <= FALL;
					walk_left_reg <= 0;
					walk_right_reg <= 0;
					aaah_reg <= 1;
					digging_reg <= 0;
				end
		endcase
	end
end

// Counter for fall duration
always @(posedge clk) begin
	if (!areset && state == FALL) begin
		fall_counter <= fall_counter + 1;
	end
end

// Assign outputs
assign walk_left = walk_left_reg;
assign walk_right = walk_right_reg;
assign aaah = aaah_reg;
assign digging = digging_reg;

endmodule
