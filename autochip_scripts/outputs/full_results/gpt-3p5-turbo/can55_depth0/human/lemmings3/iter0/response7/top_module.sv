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
reg walk_left_reg;
reg walk_right_reg;
reg dig_reg;

parameter WALK_LEFT_STATE = 2'b00;
parameter WALK_RIGHT_STATE = 2'b01;
parameter FALL_STATE = 2'b10;
parameter DIG_STATE = 2'b11;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= WALK_LEFT_STATE;
		walk_left_reg <= 1'b1;
		walk_right_reg <= 1'b0;
		dig_reg <= 1'b0;
	end else begin
		case (state)
			WALK_LEFT_STATE: begin
				if (bump_right && !bump_left)
					state <= WALK_RIGHT_STATE;
				else if (ground == 1'b0)
					state <= FALL_STATE;
				else if (dig == 1'b1 && ground == 1'b1)
					state <= DIG_STATE;
				else
					state <= WALK_LEFT_STATE;
			end
			WALK_RIGHT_STATE: begin
				if (bump_left && !bump_right)
					state <= WALK_LEFT_STATE;
				else if (ground == 1'b0)
					state <= FALL_STATE;
				else if (dig == 1'b1 && ground == 1'b1)
					state <= DIG_STATE;
				else
					state <= WALK_RIGHT_STATE;
			end
			FALL_STATE: begin
				if (ground == 1'b1)
					state <= state;
				else
					state <= FALL_STATE;
			end
			DIG_STATE: begin
				if (ground == 1'b0)
					state <= state;
				else
					state <= WALK_RIGHT_STATE;
			end
			default: state <= WALK_LEFT_STATE;
		endcase
	end
end

always @(state) begin
	case (state)
		WALK_LEFT_STATE: begin
			walk_left = 1'b1;
			walk_right = 1'b0;
			digging = 1'b0;
			aaah = 1'b0;
		end
		WALK_RIGHT_STATE: begin
			walk_left = 1'b0;
			walk_right = 1'b1;
			digging = 1'b0;
			aaah = 1'b0;
		end
		FALL_STATE: begin
			walk_left = 1'b0;
			walk_right = 1'b0;
			digging = 1'b0;
			aaah = 1'b1;
		end
		DIG_STATE: begin
			walk_left = 1'b0;
			walk_right = 1'b0;
			digging = 1'b1;
			aaah = 1'b0;
		end
		default: begin
			walk_left = 1'b1;
			walk_right = 1'b0;
			digging = 1'b0;
			aaah = 1'b0;
		end
	endcase
end

endmodule
