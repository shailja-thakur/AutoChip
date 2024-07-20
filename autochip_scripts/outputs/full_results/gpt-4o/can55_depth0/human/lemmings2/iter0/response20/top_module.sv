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

    // Define states
    typedef enum logic [2:0] {
        LEFT = 3'b000,
        RIGHT = 3'b001,
        FALL_LEFT = 3'b010,
        FALL_RIGHT = 3'b011
    } state_t;

    state_t state, next_state;

    // State transition combinational logic
    always @(*) begin
        case (state)
            LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
                else if (bump_left || bump_right)
                    next_state = RIGHT;
                else
                    next_state = LEFT;
            end
            RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
                else if (bump_left || bump_right)
                    next_state = LEFT;
                else
                    next_state = RIGHT;
            end
            FALL_LEFT: begin
                if (ground)
                    next_state = LEFT;
                else
                    next_state = FALL_LEFT;
            end
            FALL_RIGHT: begin
                if (ground)
                    next_state = RIGHT;
                else
                    next_state = FALL_RIGHT;
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

    // Output logic based on the current state
    always @(*) begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;

        case (state)
            LEFT: walk_left = 1;
            RIGHT: walk_right = 1;
            FALL_LEFT, FALL_RIGHT: aaah = 1;
        endcase
    end

endmodule
