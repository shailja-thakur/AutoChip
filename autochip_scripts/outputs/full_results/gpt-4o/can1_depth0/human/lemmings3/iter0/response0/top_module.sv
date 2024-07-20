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

    // States of the FSM
    typedef enum logic [2:0] {
        WALK_LEFT,
        WALK_RIGHT,
        FALL_LEFT,
        FALL_RIGHT,
        DIG_LEFT,
        DIG_RIGHT
    } state_t;

    state_t state, next_state;

    // Asynchronous reset and state transitions
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= WALK_LEFT;
        else
            state <= next_state;
    end
    
    // Next state logic
    always_comb begin
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
            FALL_LEFT: begin
                if (ground)
                    next_state = WALK_LEFT;
            end
            FALL_RIGHT: begin
                if (ground)
                    next_state = WALK_RIGHT;
            end
            DIG_LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
            end
            DIG_RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
            end
            default: next_state = WALK_LEFT; // Should never get here
        endcase
    end

    // Output logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
        end else begin
            case (state)
                WALK_LEFT: begin
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                end
                WALK_RIGHT: begin
                    walk_left <= 0;
                    walk_right <= 1;
                    aaah <= 0;
                    digging <= 0;
                end
                FALL_LEFT, FALL_RIGHT: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                    digging <= 0;
                end
                DIG_LEFT: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 1;
                end
                DIG_RIGHT: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 1;
                end
            endcase
        end
    end

endmodule
