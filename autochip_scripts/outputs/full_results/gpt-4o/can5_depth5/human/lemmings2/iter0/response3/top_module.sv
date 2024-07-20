module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output reg walk_left,
    output reg walk_right,
    output reg aaah
);

    typedef enum reg [2:0] {
        LEFT = 3'd0,   // Walking left
        RIGHT = 3'd1,  // Walking right
        FALL_LEFT = 3'd2,  // Falling while previously walking left
        FALL_RIGHT = 3'd3  // Falling while previously walking right
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
                else if (bump_left || (bump_left && bump_right))
                    next_state = RIGHT;
                else if (bump_right)
                    next_state = LEFT;  // Even with bump right, stays LEFT since we first handle bump_left
                else
                    next_state = LEFT;
            end
            RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
                else if (bump_right || (bump_left && bump_right))
                    next_state = LEFT;
                else if (bump_left)
                    next_state = RIGHT;  // Even with bump left, stays RIGHT since we first handle bump_right
                else
                    next_state = RIGHT;
            end
            FALL_LEFT: begin
                if (ground)
                    next_state = LEFT;
                else
                    next_state = FALL_LEFT;
            end
            FALL_RIGHT: begin
                if (ground)
                    next_state = RIGHT;
                else
                    next_state = FALL_RIGHT;
            end
            default: begin
                next_state = LEFT;  // Default to walking left
            end
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= LEFT;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        // Default outputs
        walk_left = 0;
        walk_right = 0;
        aaah = 0;

        case (state)
            LEFT: begin
                walk_left = 1;
            end
            RIGHT: begin
                walk_right = 1;
            end
            FALL_LEFT, FALL_RIGHT: begin
                aaah = 1;
            end
        endcase
    end

endmodule
