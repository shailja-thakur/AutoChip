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

reg [1:0] state;

parameter WALK_LEFT = 2'b00;
parameter WALK_RIGHT = 2'b01;
parameter FALL = 2'b10;
parameter DIG = 2'b11;

reg aaah_out;
reg digging_out;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= WALK_LEFT;
		aaah_out <= 0;
		digging_out <= 0;
	else begin
		case (state)
			WALK_LEFT: begin
				if (bump_right && !bump_left)
					state <= WALK_RIGHT;
				else if (!ground)
					state <= FALL;
				else if (dig)
					state <= DIG;
			end
			WALK_RIGHT: begin
				if (bump_left && !bump_right)
					state <= WALK_LEFT;
				else if (!ground)
					state <= FALL;
				else if (dig)
					state <= DIG;
			end
			FALL: begin
				if (ground)
					state <= state == WALK_LEFT ? WALK_LEFT : WALK_RIGHT;
			end
			DIG: begin
				if (!ground)
					state <= FALL;
				else if (!dig)
					state <= state == WALK_LEFT ? WALK_LEFT : WALK_RIGHT;
			end
		endcase
	end
end

always @(state) begin
	case (state)
		WALK_LEFT: begin
			walk_left = 1;
			walk_right = 0;
			aaah = 0;
			digging = 0;
		end
		WALK_RIGHT: begin
			walk_left = 0;
			walk_right = 1;
			aaah = 0;
			digging = 0;
		end
		FALL: begin
			walk_left = 0;
			walk_right = 0;
			aaah = 1;
			digging = 0;
		end
		DIG: begin
			walk_left = 0;
			walk_right = 0;
			aaah = 0;
			digging = 1;
		end
	endcase
end

endmodule
