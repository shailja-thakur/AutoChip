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
        LEFT,       // walking left
        RIGHT,      // walking right
        FALL_LEFT,  // falling from walking left
        FALL_RIGHT, // falling from walking right
        DIG_LEFT,   // digging from walking left
        DIG_RIGHT   // digging from walking right
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
                else if (dig)
                    next_state = DIG_LEFT;
                else if (bump_left)
                    next_state = RIGHT;
                else if (bump_right)
                    next_state = RIGHT;
                else
                    next_state = LEFT;
            end
            RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
                else if (dig)
                    next_state = DIG_RIGHT;
                else if (bump_right)
                    next_state = LEFT;
                else if (bump_left)
                    next_state = LEFT;
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
            DIG_LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
                else
                    next_state = DIG_LEFT;
            end
            DIG_RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
                else
                    next_state = DIG_RIGHT;
            end
            default: next_state = LEFT;
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
        walk_left  = (state == LEFT);
        walk_right = (state == RIGHT);
        aaah       = (state == FALL_LEFT) || (state == FALL_RIGHT);
        digging    = (state == DIG_LEFT) || (state == DIG_RIGHT);
    end
endmodule
