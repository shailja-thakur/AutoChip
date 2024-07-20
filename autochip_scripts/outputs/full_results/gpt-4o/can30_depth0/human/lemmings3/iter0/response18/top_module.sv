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

    // Define state encoding
    typedef enum logic [2:0] {
        S_WALK_LEFT = 3'b000,
        S_WALK_RIGHT = 3'b001,
        S_FALL_LEFT = 3'b010,
        S_FALL_RIGHT = 3'b011,
        S_DIG_LEFT = 3'b100,
        S_DIG_RIGHT = 3'b101
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            S_WALK_LEFT: begin
                if (!ground)
                    next_state = S_FALL_LEFT;
                else if (dig)
                    next_state = S_DIG_LEFT;
                else if (bump_left || bump_right)
                    next_state = S_WALK_RIGHT;
                else
                    next_state = S_WALK_LEFT;
            end
            S_WALK_RIGHT: begin
                if (!ground)
                    next_state = S_FALL_RIGHT;
                else if (dig)
                    next_state = S_DIG_RIGHT;
                else if (bump_left || bump_right)
                    next_state = S_WALK_LEFT;
                else
                    next_state = S_WALK_RIGHT;
            end
            S_FALL_LEFT: begin
                if (ground)
                    next_state = S_WALK_LEFT;
                else
                    next_state = S_FALL_LEFT;
            end
            S_FALL_RIGHT: begin
                if (ground)
                    next_state = S_WALK_RIGHT;
                else
                    next_state = S_FALL_RIGHT;
            end
            S_DIG_LEFT: begin
                if (!ground)
                    next_state = S_FALL_LEFT;
                else
                    next_state = S_DIG_LEFT;
            end
            S_DIG_RIGHT: begin
                if (!ground)
                    next_state = S_FALL_RIGHT;
                else
                    next_state = S_DIG_RIGHT;
            end
            default: next_state = S_WALK_LEFT;
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= S_WALK_LEFT;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        
        case (state)
            S_WALK_LEFT: walk_left = 1;
            S_WALK_RIGHT: walk_right = 1;
            S_FALL_LEFT,
            S_FALL_RIGHT: aaah = 1;
            S_DIG_LEFT,
            S_DIG_RIGHT: digging = 1;
        endcase
    end

endmodule
