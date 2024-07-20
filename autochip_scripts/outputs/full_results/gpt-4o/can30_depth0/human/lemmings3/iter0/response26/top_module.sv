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

    // State encoding
    typedef enum reg [2:0] {
        S_WALK_LEFT = 3'b000,
        S_WALK_RIGHT = 3'b001,
        S_FALLING_LEFT = 3'b010,
        S_FALLING_RIGHT = 3'b011,
        S_DIGGING_LEFT = 3'b100,
        S_DIGGING_RIGHT = 3'b101
    } state_t;

    state_t state, next_state;

    // State transitions
    always @(*) begin
        case (state)
            S_WALK_LEFT: begin
                if (!ground)
                    next_state = S_FALLING_LEFT;
                else if (dig)
                    next_state = S_DIGGING_LEFT;
                else if (bump_left)
                    next_state = S_WALK_RIGHT;
                else
                    next_state = S_WALK_LEFT;
            end
            S_WALK_RIGHT: begin
                if (!ground)
                    next_state = S_FALLING_RIGHT;
                else if (dig)
                    next_state = S_DIGGING_RIGHT;
                else if (bump_right)
                    next_state = S_WALK_LEFT;
                else
                    next_state = S_WALK_RIGHT;
            end
            S_FALLING_LEFT: begin
                if (ground)
                    next_state = S_WALK_LEFT;
                else
                    next_state = S_FALLING_LEFT;
            end
            S_FALLING_RIGHT: begin
                if (ground)
                    next_state = S_WALK_RIGHT;
                else
                    next_state = S_FALLING_RIGHT;
            end
            S_DIGGING_LEFT: begin
                if (!ground)
                    next_state = S_FALLING_LEFT;
                else
                    next_state = S_DIGGING_LEFT;
            end
            S_DIGGING_RIGHT: begin
                if (!ground)
                    next_state = S_FALLING_RIGHT;
                else
                    next_state = S_DIGGING_RIGHT;
            end
            default: next_state = S_WALK_LEFT;
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= S_WALK_LEFT;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;

        case (state)
            S_WALK_LEFT: walk_left = 1;
            S_WALK_RIGHT: walk_right = 1;
            S_FALLING_LEFT: aaah = 1;
            S_FALLING_RIGHT: aaah = 1;
            S_DIGGING_LEFT: digging = 1;
            S_DIGGING_RIGHT: digging = 1;
        endcase
    end
endmodule
