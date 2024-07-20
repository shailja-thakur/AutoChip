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

reg [4:0] state;
reg walk_left;
reg walk_right;
reg aaah;
reg digging;

reg [4:0] fall_counter;
reg splatter;

parameter WALK_LEFT = 5'b00001;
parameter WALK_RIGHT = 5'b00010;
parameter FALL = 5'b00100;
parameter DIG = 5'b01000;
parameter SPLATTER = 5'b10000;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= WALK_LEFT;
		walk_left <= 1;
		walk_right <= 0;
		aaah <= 0;
		digging <= 0;
		fall_counter <= 0;
		splatter <= 0;
	end else begin
		case(state)
			WALK_LEFT: begin
				if (bump_right && !bump_left && ground) begin
					state <= WALK_RIGHT;
					walk_left <= 0;
					walk_right <= 1;
					aaah <= 0;
					digging <= 0;
					fall_counter <= 0;
				end else if (!ground) begin
					state <= FALL;
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 1;
					digging <= 0;
					fall_counter <= 0;
				end else if (dig && ground) begin
					state <= DIG;
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 0;
					digging <= 1;
					fall_counter <= 0;
				end
			end
			WALK_RIGHT: begin
				if (bump_left && !bump_right && ground) begin
					state <= WALK_LEFT;
					walk_left <= 1;
					walk_right <= 0;
					aaah <= 0;
					digging <= 0;
					fall_counter <= 0;
				end else if (!ground) begin
					state <= FALL;
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 1;
					digging <= 0;
					fall_counter <= 0;
				end else if (dig && ground) begin
					state <= DIG;
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 0;
					digging <= 1;
					fall_counter <= 0;
				end
			end
			FALL: begin
				if (ground) begin
					state <= state;
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 0;
					digging <= 0;
					fall_counter <= 0;
				end else if (fall_counter >= 20) begin
					state <= SPLATTER;
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 0;
					digging <= 0;
					fall_counter <= 0;
					splatter <= 1;
				end else begin
					state <= state;
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 1;
					digging <= 0;
					fall_counter <= fall_counter + 1;
				end
			end
			DIG: begin
				if (!ground) begin
					state <= FALL;
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 1;
					digging <= 0;
					fall_counter <= 0;
				end else begin
					state <= state;
					walk_left <= 0;
					walk_right <= 0;
					aaah <= 0;
					digging <= 1;
					fall_counter <= 0;
				end
			end
		endcase
	end
end

endmodule
