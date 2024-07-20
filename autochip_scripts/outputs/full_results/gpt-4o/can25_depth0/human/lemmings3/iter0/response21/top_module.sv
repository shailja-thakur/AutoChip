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
    // State encoding
    typedef enum logic [
        L_WALK_LEFT,
        L_WALK_RIGHT,
        L_FALL_LEFT,
        L_FALL_RIGHT,
        L_DIG_LEFT,
        L_DIG_RIGHT
    ] state_t;

    state_t state, next_state;

    // State transitions
    always @(*) begin
        next_state = state;
        case (state)
            L_WALK_LEFT: begin
                if (!ground)
                    next_state = L_FALL_LEFT;
                else if (dig)
                    next_state = L_DIG_LEFT;
                else if (bump_left)
                    next_state = L_WALK_RIGHT;
                else
                    next_state = L_WALK_LEFT;
            end

            L_WALK_RIGHT: begin
                if (!ground)
                    next_state = L_FALL_RIGHT;
                else if (dig)
                    next_state = L_DIG_RIGHT;
                else if (bump_right)
                    next_state = L_WALK_LEFT;
                else
                    next_state = L_WALK_RIGHT;
            end

            L_FALL_LEFT: begin
                if (ground)
                    next_state = L_WALK_LEFT;
                else
                    next_state = L_FALL_LEFT;
            end

            L_FALL_RIGHT: begin
                if (ground)
                    next_state = L_WALK_RIGHT;
                else
                    next_state = L_FALL_RIGHT;
            end

            L_DIG_LEFT: begin
                if (!ground)
                    next_state = L_FALL_LEFT;
                else
                    next_state = L_DIG_LEFT;
            end

            L_DIG_RIGHT: begin
                if (!ground)
                    next_state = L_FALL_RIGHT;
                else
                    next_state = L_DIG_RIGHT;
            end

            default: next_state = L_WALK_LEFT;  // default state
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= L_WALK_LEFT;
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
            L_WALK_LEFT: walk_left = 1;
            L_WALK_RIGHT: walk_right = 1;
            L_FALL_LEFT: aaah = 1;
            L_FALL_RIGHT: aaah = 1;
            L_DIG_LEFT: digging = 1;
            L_DIG_RIGHT: digging = 1;
        endcase
    end

endmodule
