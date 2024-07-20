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

    // State encoding
    typedef enum reg [1:0] {
        WALK_LEFT = 2'b00,
        WALK_RIGHT = 2'b01,
        FALL_LEFT = 2'b10,
        FALL_RIGHT = 2'b11
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            WALK_LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
                else if (bump_left || bump_right)
                    next_state = WALK_RIGHT;
                else
                    next_state = WALK_LEFT;
            end
            WALK_RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
                else if (bump_left || bump_right)
                    next_state = WALK_LEFT;
                else
                    next_state = WALK_RIGHT;
            end
            FALL_LEFT: begin
                if (ground)
                    next_state = WALK_LEFT;
                else
                    next_state = FALL_LEFT;
            end
            FALL_RIGHT: begin
                if (ground)
                    next_state = WALK_RIGHT;
                else
                    next_state = FALL_RIGHT;
            end
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
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        case (state)
            WALK_LEFT: walk_left = 1'b1;
            WALK_RIGHT: walk_right = 1'b1;
            FALL_LEFT, FALL_RIGHT: aaah = 1'b1;
        endcase
    end

endmodule
