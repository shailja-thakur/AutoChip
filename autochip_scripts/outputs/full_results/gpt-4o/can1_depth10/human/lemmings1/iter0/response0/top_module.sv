module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

    // Define the states
    typedef enum logic {
        STATE_WALK_LEFT,
        STATE_WALK_RIGHT
    } state_t;

    // State register
    state_t state, next_state;

    // Next state logic
    always @(*) begin
        case (state)
            STATE_WALK_LEFT: begin
                if (bump_left)
                    next_state = STATE_WALK_RIGHT;
                else
                    next_state = STATE_WALK_LEFT;
            end
            STATE_WALK_RIGHT: begin
                if (bump_right)
                    next_state = STATE_WALK_LEFT;
                else
                    next_state = STATE_WALK_RIGHT;
            end
            default: next_state = STATE_WALK_LEFT;
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_WALK_LEFT;
        else
            state <= next_state;
    end

    // Output logic
    assign walk_left = (state == STATE_WALK_LEFT);
    assign walk_right = (state == STATE_WALK_RIGHT);

endmodule
