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

    typedef enum logic [2:0] {
        WALK_LEFT   = 3'b000,
        WALK_RIGHT  = 3'b001,
        DIG_LEFT    = 3'b010,
        DIG_RIGHT   = 3'b011,
        FALL_LEFT   = 3'b100,
        FALL_RIGHT  = 3'b101
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        next_state = state; // Default to no state change
        case (state)
            WALK_LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
                else if (dig)
                    next_state = DIG_LEFT;
                else if (bump_left)
                    next_state = WALK_RIGHT;
            end
            WALK_RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
                else if (dig)
                    next_state = DIG_RIGHT;
                else if (bump_right)
                    next_state = WALK_LEFT;
            end
            DIG_LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
            end
            DIG_RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
            end
            FALL_LEFT: begin
                if (ground)
                    next_state = WALK_LEFT;
            end
            FALL_RIGHT: begin
                if (ground)
                    next_state = WALK_RIGHT;
            end
            default: next_state = WALK_LEFT; // Shouldn't happen, but just in case
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= WALK_LEFT;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;
        case (state)
            WALK_LEFT: walk_left = 1'b1;
            WALK_RIGHT: walk_right = 1'b1;
            DIG_LEFT: digging = 1'b1;
            DIG_RIGHT: digging = 1'b1;
            FALL_LEFT: aaah = 1'b1;
            FALL_RIGHT: aaah = 1'b1;
        endcase
    end

endmodule
