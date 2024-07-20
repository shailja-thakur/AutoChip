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
reg [1:0] state;

parameter S_WALK_LEFT = 2'b00;
parameter S_WALK_RIGHT = 2'b01;
parameter S_FALL = 2'b10;
parameter S_DIG = 2'b11;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		walk_left <= 1'b1;
		walk_right <= 1'b0;
		aaah <= 1'b0;
		digging <= 1'b0;
		state <= S_WALK_LEFT;
	end
	else begin
		case (state)
			S_WALK_LEFT: begin
				if (bump_right && !bump_left && ground)
					state <= S_WALK_RIGHT;
				else if (!bump_right && ground)
					state <= S_WALK_LEFT;
				else if (!ground)
					state <= S_FALL;
				else if (bump_right && bump_left && ground)
					state <= S_WALK_RIGHT;
				else if (dig && ground && !aaah)
					state <= S_DIG;
			end
			S_WALK_RIGHT: begin
				if (bump_left && !bump_right && ground)
					state <= S_WALK_LEFT;
				else if (!bump_left && ground)
					state <= S_WALK_RIGHT;
				else if (!ground)
					state <= S_FALL;
				else if (bump_right && bump_left && ground)
					state <= S_WALK_LEFT;
				else if (dig && ground && !aaah)
					state <= S_DIG;
			end
			S_FALL: begin
				if (ground)
					state <= state == S_WALK_LEFT ? S_WALK_LEFT : S_WALK_RIGHT;
				else if (dig)
					state <= S_DIG;
			end
			S_DIG: begin
				if (!ground)
					state <= S_FALL;
				else if (!dig && ground && !aaah)
					state <= state == S_WALK_LEFT ? S_WALK_LEFT : S_WALK_RIGHT;
			end
		endcase
	end
end

always @(state) begin
	case (state)
		S_WALK_LEFT: begin
			walk_left <= 1'b1;
			walk_right <= 1'b0;
			aaah <= 1'b0;
			digging <= 1'b0;
		end
		S_WALK_RIGHT: begin
			walk_left <= 1'b0;
			walk_right <= 1'b1;
			aaah <= 1'b0;
			digging <= 1'b0;
		end
		S_FALL: begin
			walk_left <= 1'b0;
			walk_right <= 1'b0;
			aaah <= 1'b1;
			digging <= 1'b0;
		end
		S_DIG: begin
			walk_left <= 1'b0;
			walk_right <= 1'b0;
			aaah <= 1'b0;
			digging <= 1'b1;
		end
	endcase
end

endmodule
