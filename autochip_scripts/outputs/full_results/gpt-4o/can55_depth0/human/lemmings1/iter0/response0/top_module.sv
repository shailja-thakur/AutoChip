module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

    // State encoding
    typedef enum logic [1:0] {
        S_LEFT = 2'b00,
        S_RIGHT = 2'b01
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            S_LEFT: begin
                if (bump_left)
                    next_state = S_RIGHT;
                else
                    next_state = S_LEFT;
            end
            S_RIGHT: begin
                if (bump_right)
                    next_state = S_LEFT;
                else
                    next_state = S_RIGHT;
            end
            default: next_state = S_LEFT;
        endcase
    end

    // State registers
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= S_LEFT;
        else
            state <= next_state;
    end

    // Output logic
    assign walk_left = (state == S_LEFT);
    assign walk_right = (state == S_RIGHT);

endmodule
