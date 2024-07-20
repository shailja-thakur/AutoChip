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

    typedef enum reg [1:0] {
        STATE_LEFT = 2'b00,
        STATE_RIGHT = 2'b01,
        STATE_FALLING_LEFT = 2'b10,
        STATE_FALLING_RIGHT = 2'b11
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        // Default to stay in current state
        next_state = state;
        case (state)
            STATE_LEFT: begin
                if (!ground)
                    next_state = STATE_FALLING_LEFT;
                else if (bump_left)
                    next_state = STATE_RIGHT;
                else
                    next_state = STATE_LEFT;
            end
            STATE_RIGHT: begin
                if (!ground)
                    next_state = STATE_FALLING_RIGHT;
                else if (bump_right)
                    next_state = STATE_LEFT;
                else
                    next_state = STATE_RIGHT;
            end
            STATE_FALLING_LEFT: begin
                if (ground)
                    next_state = STATE_LEFT;
                else
                    next_state = STATE_FALLING_LEFT;
            end
            STATE_FALLING_RIGHT: begin
                if (ground)
                    next_state = STATE_RIGHT;
                else
                    next_state = STATE_FALLING_RIGHT;
            end
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_LEFT;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        case (state)
            STATE_LEFT: walk_left = 1;
            STATE_RIGHT: walk_right = 1;
            STATE_FALLING_LEFT, STATE_FALLING_RIGHT: aaah = 1;
        endcase
    end

endmodule
