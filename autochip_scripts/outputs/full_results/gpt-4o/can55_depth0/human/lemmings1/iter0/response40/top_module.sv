module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    // Define states
    typedef enum logic [1:0] {
        WALK_LEFT = 2'b00,
        WALK_RIGHT = 2'b01
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            WALK_LEFT: next_state = (bump_left) ? WALK_RIGHT : WALK_LEFT;
            WALK_RIGHT: next_state = (bump_right) ? WALK_LEFT : WALK_RIGHT;
            default: next_state = WALK_LEFT;
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
        walk_left = (state == WALK_LEFT);
        walk_right = (state == WALK_RIGHT);
    end

endmodule
