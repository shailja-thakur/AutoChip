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

    typedef enum logic [2:0] {
        LEFT = 3'b000,
        RIGHT = 3'b001,
        FALLING_LEFT = 3'b010,
        FALLING_RIGHT = 3'b011
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            LEFT: begin
                if (!ground)
                    next_state = FALLING_LEFT;
                else if (bump_left || (bump_left && bump_right))
                    next_state = RIGHT;
                else
                    next_state = LEFT;
            end
            RIGHT: begin
                if (!ground)
                    next_state = FALLING_RIGHT;
                else if (bump_right || (bump_left && bump_right))
                    next_state = LEFT;
                else
                    next_state = RIGHT;
            end
            FALLING_LEFT: begin
                if (ground)
                    next_state = LEFT;
                else
                    next_state = FALLING_LEFT;
            end
            FALLING_RIGHT: begin
                if (ground)
                    next_state = RIGHT;
                else
                    next_state = FALLING_RIGHT;
            end
            default: next_state = LEFT;
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= LEFT;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        case (state)
            LEFT: walk_left = 1;
            RIGHT: walk_right = 1;
            FALLING_LEFT, FALLING_RIGHT: aaah = 1;
        endcase
    end

endmodule
