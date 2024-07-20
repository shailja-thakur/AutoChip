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

    typedef enum reg [2:0] {
        STATE_WALK_LEFT = 3'd0,
        STATE_WALK_RIGHT = 3'd1,
        STATE_FALL_LEFT = 3'd2,
        STATE_FALL_RIGHT = 3'd3,
        STATE_DIG_LEFT = 3'd4,
        STATE_DIG_RIGHT = 3'd5
    } state_t;

    state_t state, next_state;

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_WALK_LEFT; // Reset state to walk_left
        else
            state <= next_state;
    end

    always @(*) begin
        case (state)
            STATE_WALK_LEFT: begin
                if (!ground)
                    next_state = STATE_FALL_LEFT;
                else if (dig)
                    next_state = STATE_DIG_LEFT;
                else if (bump_left)
                    next_state = STATE_WALK_RIGHT;
                else
                    next_state = STATE_WALK_LEFT;
            end

            STATE_WALK_RIGHT: begin
                if (!ground)
                    next_state = STATE_FALL_RIGHT;
                else if (dig)
                    next_state = STATE_DIG_RIGHT;
                else if (bump_right)
                    next_state = STATE_WALK_LEFT;
                else
                    next_state = STATE_WALK_RIGHT;
            end

            STATE_FALL_LEFT: begin
                if (ground)
                    next_state = STATE_WALK_LEFT;
                else
                    next_state = STATE_FALL_LEFT;
            end

            STATE_FALL_RIGHT: begin
                if (ground)
                    next_state = STATE_WALK_RIGHT;
                else
                    next_state = STATE_FALL_RIGHT;
            end

            STATE_DIG_LEFT: begin
                if (!ground)
                    next_state = STATE_FALL_LEFT;
                else
                    next_state = STATE_DIG_LEFT;
            end

            STATE_DIG_RIGHT: begin
                if (!ground)
                    next_state = STATE_FALL_RIGHT;
                else
                    next_state = STATE_DIG_RIGHT;
            end

            default: next_state = STATE_WALK_LEFT;
        endcase
    end

    always @(*) begin
        // Default outputs
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;

        case (state)
            STATE_WALK_LEFT: walk_left = 1'b1;
            STATE_WALK_RIGHT: walk_right = 1'b1;
            STATE_FALL_LEFT: aaah = 1'b1;
            STATE_FALL_RIGHT: aaah = 1'b1;
            STATE_DIG_LEFT: digging = 1'b1;
            STATE_DIG_RIGHT: digging = 1'b1;
        endcase
    end
endmodule
