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
	reg [4:0] next_state;

	parameter IDLE_STATE = 3'b000;
	parameter WALK_LEFT_STATE = 3'b001;
	parameter WALK_RIGHT_STATE = 3'b010;
	parameter FALL_STATE = 3'b011;
	parameter DIG_STATE = 3'b100;
	parameter SPLATTER_STATE = 3'b101;

	// State transition logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= IDLE_STATE;
		end
		else begin
			state <= next_state;
		end
	end

	// Next state logic
	always @(state or bump_left or bump_right or ground or dig) begin
		case (state)
			IDLE_STATE:
				if (areset) begin
					next_state <= WALK_LEFT_STATE;
				end
				else begin
					if (bump_left && !bump_right) begin
						next_state <= WALK_RIGHT_STATE;
					end
					else if (bump_right && !bump_left) begin
						next_state <= WALK_LEFT_STATE;
					end
					else if (bump_left && bump_right) begin
						next_state <= WALK_RIGHT_STATE;
					end
					else if (!ground) begin
						next_state <= FALL_STATE;
					end
					else if (dig) begin
						next_state <= DIG_STATE;
					end
					else begin
						next_state <= state;
					end
				end

			WALK_LEFT_STATE:
				if (!ground) begin
					next_state <= FALL_STATE;
				end
				else begin
					next_state <= state;
				end

			WALK_RIGHT_STATE:
				if (!ground) begin
					next_state <= FALL_STATE;
				end
				else begin
					next_state <= state;
				end

			FALL_STATE:
				if (ground) begin
					next_state <= state;
				end
				else begin
					next_state <= FALL_STATE;
				end

			DIG_STATE:
				if (!ground) begin
					next_state <= FALL_STATE;
				end
				else if (!dig) begin
					next_state <= state;
				end
				else begin
					next_state <= DIG_STATE;
				end

			SPLATTER_STATE:
				next_state <= SPLATTER_STATE;

			default:
				next_state <= IDLE_STATE;
		endcase
	end

	// Output logic
	always @(state) begin
		case (state)
			IDLE_STATE:
				walk_left <= 1;
				walk_right <= 0;
				aaah <= 0;
				digging <= 0;

			WALK_LEFT_STATE:
				walk_left <= 1;
				walk_right <= 0;
				aaah <= 0;
				digging <= 0;

			WALK_RIGHT_STATE:
				walk_left <= 0;
				walk_right <= 1;
				aaah <= 0;
				digging <= 0;

			FALL_STATE:
				walk_left <= 1;
				walk_right <= 1;
				aaah <= 1;
				digging <= 0;

			DIG_STATE:
				walk_left <= 1;
				walk_right <= 1;
				aaah <= 0;
				digging <= 1;

			SPLATTER_STATE:
				walk_left <= 0;
				walk_right <= 0;
				aaah <= 0;
				digging <= 0;

			default:
				walk_left <= 0;
				walk_right <= 0;
				aaah <= 0;
				digging <= 0;
		endcase
	end
endmodule
