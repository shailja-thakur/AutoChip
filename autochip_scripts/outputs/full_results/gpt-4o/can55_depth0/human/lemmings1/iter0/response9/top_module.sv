module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

    typedef enum logic [1:0] {
        STATE_LEFT = 2'b00,
        STATE_RIGHT = 2'b01
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            STATE_LEFT: begin
                if (bump_left)
                    next_state = STATE_RIGHT;
                else
                    next_state = STATE_LEFT;
            end
            STATE_RIGHT: begin
                if (bump_right)
                    next_state = STATE_LEFT;
                else
                    next_state = STATE_RIGHT;
            end
            default: next_state = STATE_LEFT;
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
    assign walk_left = (state == STATE_LEFT);
    assign walk_right = (state == STATE_RIGHT);

endmodule
