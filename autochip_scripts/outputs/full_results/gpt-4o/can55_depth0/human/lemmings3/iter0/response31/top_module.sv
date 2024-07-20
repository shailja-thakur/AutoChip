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

    // States enumeration
    typedef enum logic [2:0] {
        WALKING_LEFT,
        WALKING_RIGHT,
        FALLING_LEFT,
        FALLING_RIGHT,
        DIGGING_LEFT,
        DIGGING_RIGHT
    } state_t;

    state_t state, next_state;

    always @(*) begin
        // Default values for outputs
        walk_left  = 0;
        walk_right = 0;
        aaah       = 0;
        digging    = 0;

        case(state)
            WALKING_LEFT: begin
                walk_left = 1;
                if (!ground)
                    next_state = FALLING_LEFT;
                else if (dig)
                    next_state = DIGGING_LEFT;
                else if (bump_left)
                    next_state = WALKING_RIGHT;
                else
                    next_state = WALKING_LEFT;
            end
            WALKING_RIGHT: begin
                walk_right = 1;
                if (!ground)
                    next_state = FALLING_RIGHT;
                else if (dig)
                    next_state = DIGGING_RIGHT;
                else if (bump_right)
                    next_state = WALKING_LEFT;
                else
                    next_state = WALKING_RIGHT;
            end
            FALLING_LEFT: begin
                aaah = 1;
                if (ground)
                    next_state = WALKING_LEFT;
                else
                    next_state = FALLING_LEFT;
            end
            FALLING_RIGHT: begin
                aaah = 1;
                if (ground)
                    next_state = WALKING_RIGHT;
                else
                    next_state = FALLING_RIGHT;
            end
            DIGGING_LEFT: begin
                digging = 1;
                if (!ground)
                    next_state = FALLING_LEFT;
                else
                    next_state = DIGGING_LEFT;
            end
            DIGGING_RIGHT: begin
                digging = 1;
                if (!ground)
                    next_state = FALLING_RIGHT;
                else
                    next_state = DIGGING_RIGHT;
            end
        endcase
    end

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= WALKING_LEFT;
        else
            state <= next_state;
    end

endmodule
