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
        LEFT = 2'b00,
        RIGHT = 2'b01,
        FALLING_LEFT = 2'b10,
        FALLING_RIGHT = 2'b11
    } state_t;

    state_t state, next_state;

    // State transition logic (next state)
    always @(*) begin
        case (state)
            LEFT: begin
                if (!ground)
                    next_state = FALLING_LEFT;
                else if (bump_left)
                    next_state = RIGHT;
                else
                    next_state = LEFT;
            end
            RIGHT: begin
                if (!ground)
                    next_state = FALLING_RIGHT;
                else if (bump_right)
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
            FALLING_LEFT: aaah = 1;
            FALLING_RIGHT: aaah = 1;
        endcase
    end

endmodule
