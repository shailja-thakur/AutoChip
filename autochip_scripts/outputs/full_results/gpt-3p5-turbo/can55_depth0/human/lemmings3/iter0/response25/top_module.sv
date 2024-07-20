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

	parameter STATE_WALK_LEFT = 2'b00;
	parameter STATE_WALK_RIGHT = 2'b01;
	parameter STATE_FALL = 2'b10;
	parameter STATE_DIG = 2'b11;

	reg [1:0] state, next_state;

	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= STATE_WALK_LEFT;
		else
			state <= next_state;
	end

	always @* begin
		case (state)
            STATE_WALK_LEFT: begin
                if (bump_right & !bump_left)
                    next_state = STATE_WALK_RIGHT;
                else if (!bump_right & bump_left)
                    next_state = STATE_WALK_LEFT;
                else if (!ground)
                    next_state = STATE_FALL;
                else if (dig)
                    next_state = STATE_DIG;
                else
                    next_state = STATE_WALK_LEFT;
            end
            STATE_WALK_RIGHT: begin
                if (bump_left & !bump_right)
                    next_state = STATE_WALK_LEFT;
                else if (!bump_left & bump_right)
                    next_state = STATE_WALK_RIGHT;
                else if (!ground)
                    next_state = STATE_FALL;
                else if (dig)
                    next_state = STATE_DIG;
                else
                    next_state = STATE_WALK_RIGHT;
            end
            STATE_FALL: begin
                if (ground)
                    next_state = state;
                else if (dig)
                    next_state = STATE_DIG;
                else
                    next_state = STATE_FALL;
            end
            STATE_DIG: begin
                if (ground)
                    next_state = state;
                else if (!ground)
                    next_state = STATE_FALL;
                else
                    next_state = STATE_DIG;
            end
        endcase
	end

	always @* begin
		case (state)
            STATE_WALK_LEFT: begin
                walk_left = 1;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end
            STATE_WALK_RIGHT: begin
                walk_left = 0;
                walk_right = 1;
                aaah = 0;
                digging = 0;
            end
            STATE_FALL: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 1;
                digging = 0;
            end
            STATE_DIG: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 1;
            end
        endcase
	end

endmodule
