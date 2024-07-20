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

	typedef enum reg [2:0] {
		S_WALK_LEFT    = 3'b000,
		S_WALK_RIGHT   = 3'b001,
		S_FALL_LEFT    = 3'b010,
		S_FALL_RIGHT   = 3'b011,
		S_DIG_LEFT     = 3'b100,
		S_DIG_RIGHT    = 3'b101,
		S_SPLATTER     = 3'b110
	} state_t;

	state_t state, next_state;
	reg [4:0] fall_counter;

	always @ (posedge clk or posedge areset) begin
		if (areset) begin
			state <= S_WALK_LEFT;
			fall_counter <= 5'd0;
		end else begin
			state <= next_state;
			if (aaah)
				fall_counter <= fall_counter + 5'd1;
			else
				fall_counter <= 5'd0;
		end
	end

	always @ (*) begin
		next_state = state;
		case (state)
			S_WALK_LEFT: begin
				if (~ground) begin
					next_state = S_FALL_LEFT;
				end else if (dig) begin
					next_state = S_DIG_LEFT;
				end else if (bump_left) begin
					next_state = S_WALK_RIGHT;
				end
			end

			S_WALK_RIGHT: begin
				if (~ground) begin
					next_state = S_FALL_RIGHT;
				end else if (dig) begin
					next_state = S_DIG_RIGHT;
				end else if (bump_right) begin
					next_state = S_WALK_LEFT;
				end
			end

			S_FALL_LEFT, S_FALL_RIGHT: begin
				if (fall_counter >= 5'd20) begin
					next_state = S_SPLATTER;
				end else if (ground) begin
					next_state = (state == S_FALL_LEFT) ? S_WALK_LEFT : S_WALK_RIGHT;
				end
			end

			S_DIG_LEFT, S_DIG_RIGHT: begin
				if (~ground) begin
					next_state = (state == S_DIG_LEFT) ? S_FALL_LEFT : S_FALL_RIGHT;
				end
			end

			S_SPLATTER: begin
				// Remain in this state forever once splattered
			end
		endcase
	end

	always @ (*) begin
		// Default values
		walk_left  = 1'b0;
		walk_right = 1'b0;
		aaah       = 1'b0;
		digging    = 1'b0;

		case (state)
			S_WALK_LEFT: begin
				walk_left = 1'b1;
			end

			S_WALK_RIGHT: begin
				walk_right = 1'b1;
			end

			S_FALL_LEFT: begin
				aaah = 1'b1;
			end

			S_FALL_RIGHT: begin
				aaah = 1'b1;
			end

			S_DIG_LEFT: begin
				digging = 1'b1;
			end

			S_DIG_RIGHT: begin
				digging = 1'b1;
			end

			S_SPLATTER: begin
				// All outputs are 0
			end
		endcase
	end

endmodule
