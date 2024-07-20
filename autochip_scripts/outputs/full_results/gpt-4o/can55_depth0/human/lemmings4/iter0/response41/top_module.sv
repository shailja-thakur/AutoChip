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

    // Define states for the FSM
    typedef enum logic [2:0] {
        STATE_WALK_LEFT,
        STATE_WALK_RIGHT,
        STATE_FALL_LEFT,
        STATE_FALL_RIGHT,
        STATE_DIG_LEFT,
        STATE_DIG_RIGHT,
        STATE_SPLATTERED
    } state_t;

    state_t state, next_state;
    int falling_counter;

    // State transition logic
    always_comb begin
        next_state = state; // Default to remain in the current state
        case (state)
            STATE_WALK_LEFT: begin
                if (!ground)
                    next_state = STATE_FALL_LEFT;
                else if (dig)
                    next_state = STATE_DIG_LEFT;
                else if (bump_left)
                    next_state = STATE_WALK_RIGHT;
            end
            STATE_WALK_RIGHT: begin
                if (!ground)
                    next_state = STATE_FALL_RIGHT;
                else if (dig)
                    next_state = STATE_DIG_RIGHT;
                else if (bump_right)
                    next_state = STATE_WALK_LEFT;
            end
            STATE_FALL_LEFT: begin
                if (ground) begin
                    if (falling_counter > 20)
                        next_state = STATE_SPLATTERED;
                    else
                        next_state = STATE_WALK_LEFT;
                end
            end
            STATE_FALL_RIGHT: begin
                if (ground) begin
                    if (falling_counter > 20)
                        next_state = STATE_SPLATTERED;
                    else
                        next_state = STATE_WALK_RIGHT;
                end
            end
            STATE_DIG_LEFT: begin
                if (!ground)
                    next_state = STATE_FALL_LEFT;
            end
            STATE_DIG_RIGHT: begin
                if (!ground)
                    next_state = STATE_FALL_RIGHT;
            end
            STATE_SPLATTERED: begin
                // Remain in splattered state
            end
            default: next_state = STATE_WALK_LEFT;
        endcase
    end

    // State sequential logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_WALK_LEFT;
            falling_counter <= 0;
        end else begin
            if (state == STATE_FALL_LEFT || state == STATE_FALL_RIGHT)
                falling_counter <= falling_counter + 1;
            else
                falling_counter <= 0;
            state <= next_state;
        end
    end

    // Output logic
    always_comb begin
        walk_left = (state == STATE_WALK_LEFT);
        walk_right = (state == STATE_WALK_RIGHT);
        aaah = (state == STATE_FALL_LEFT || state == STATE_FALL_RIGHT);
        digging = (state == STATE_DIG_LEFT || state == STATE_DIG_RIGHT);
    end

endmodule
