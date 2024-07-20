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
        WALK_LEFT  = 2'b01,
        WALK_RIGHT = 2'b10
    } state_t;

    // Internal state variable
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            WALK_LEFT: begin
                if (bump_left)
                    next_state = WALK_RIGHT;
                else
                    next_state = WALK_LEFT;
            end
            WALK_RIGHT: begin
                if (bump_right)
                    next_state = WALK_LEFT;
                else
                    next_state = WALK_RIGHT;
            end
            default: next_state = WALK_LEFT; // Default state for safety
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
    assign walk_left = (state == WALK_LEFT);
    assign walk_right = (state == WALK_RIGHT);

endmodule
