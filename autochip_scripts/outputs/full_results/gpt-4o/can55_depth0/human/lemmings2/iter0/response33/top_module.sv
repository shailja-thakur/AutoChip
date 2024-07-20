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
    typedef enum logic [2:0] {
        S_WALK_LEFT = 3'b000,
        S_WALK_RIGHT = 3'b001,
        S_FALL_LEFT = 3'b010,
        S_FALL_RIGHT = 3'b011
    } state_t;

    state_t state, next_state;

    // State transition
    always @(*) begin
        case (state)
            S_WALK_LEFT: begin
                if (!ground)
                    next_state = S_FALL_LEFT;
                else if (bump_left)
                    next_state = S_WALK_RIGHT;
                else
                    next_state = S_WALK_LEFT;
            end

            S_WALK_RIGHT: begin
                if (!ground)
                    next_state = S_FALL_RIGHT;
                else if (bump_right)
                    next_state = S_WALK_LEFT;
                else
                    next_state = S_WALK_RIGHT;
            end

            S_FALL_LEFT: begin
                if (ground)
                    next_state = S_WALK_LEFT;
                else
                    next_state = S_FALL_LEFT;
            end

            S_FALL_RIGHT: begin
                if (ground)
                    next_state = S_WALK_RIGHT;
                else
                    next_state = S_FALL_RIGHT;
            end

            default: next_state = S_WALK_LEFT;
        endcase
    end

    // State register
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
        
        case (state)
            S_WALK_LEFT: walk_left = 1;
            S_WALK_RIGHT: walk_right = 1;
            S_FALL_LEFT, S_FALL_RIGHT: aaah = 1;
        endcase
    end

endmodule
