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
	reg [4:0] state;

	parameter WALK_LEFT_STATE = 3'b000;
	parameter WALK_RIGHT_STATE = 3'b001;
	parameter FALL_STATE = 3'b010;
	parameter DIG_STATE = 3'b011;
	parameter SPLATTER_STATE = 3'b100;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= WALK_LEFT_STATE;
			walk_left <= 1;
			walk_right <= 0;
			aaah <= 0;
			digging <= 0;
		end
		else begin
			case (state)
				WALK_LEFT_STATE: begin
					if (bump_right)
						state <= WALK_RIGHT_STATE;
					else if (ground)
						state <= WALK_LEFT_STATE;
					else
						state <= FALL_STATE;
				end
				WALK_RIGHT_STATE: begin
					if (bump_left)
						state <= WALK_LEFT_STATE;
					else if (ground)
						state <= WALK_RIGHT_STATE;
					else
						state <= FALL_STATE;
				end
				FALL_STATE: begin
					if (ground)
						state <= state;
					else if (state == DIG_STATE && dig)
						state <= DIG_STATE;
					else if (state == FALL_STATE && aaah)
						state <= SPLATTER_STATE;
					else if (dig)
						state <= DIG_STATE;
					else if (!dig && walk_left)
						state <= WALK_LEFT_STATE;
					else if (!dig && walk_right)
						state <= WALK_RIGHT_STATE;
				end
				DIG_STATE: begin
					if (ground && !dig)
						state <= FALL_STATE;
					else
						state <= DIG_STATE;
				end
				SPLATTER_STATE: begin
					state <= SPLATTER_STATE;
				end
			endcase
		end
	end

	always @(state) begin
		case (state)
			WALK_LEFT_STATE: begin
				walk_left <= 1;
				walk_right <= 0;
				aaah <= 0;
				digging <= 0;
			end
			WALK_RIGHT_STATE: begin
				walk_left <= 0;
				walk_right <= 1;
				aaah <= 0;
				digging <= 0;
			end
			FALL_STATE: begin
				walk_left <= 0;
				walk_right <= 0;
				aaah <= 1;
				digging <= 0;
			end
			DIG_STATE: begin
				walk_left <= 0;
				walk_right <= 0;
				aaah <= 0;
				digging <= 1;
			end
			SPLATTER_STATE: begin
				walk_left <= 0;
				walk_right <= 0;
				aaah <= 0;
				digging <= 0;
			end
		endcase
	end
endmodule
