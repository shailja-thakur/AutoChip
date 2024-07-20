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

    typedef enum logic [1:0] {
        STATE_WALK_LEFT = 2'b00,
        STATE_WALK_RIGHT = 2'b01,
        STATE_FALL_LEFT = 2'b10,
        STATE_FALL_RIGHT = 2'b11
    } state_t;

    state_t state, next_state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_WALK_LEFT;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case (state)
            STATE_WALK_LEFT: begin
                if (!ground)
                    next_state = STATE_FALL_LEFT;
                else if (bump_left)
                    next_state = STATE_WALK_RIGHT;
                else
                    next_state = STATE_WALK_LEFT;
            end
            STATE_WALK_RIGHT: begin
                if (!ground)
                    next_state = STATE_FALL_RIGHT;
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
            default: next_state = STATE_WALK_LEFT;
        endcase
    end

    always @(*) begin
        walk_left = (state == STATE_WALK_LEFT);
        walk_right = (state == STATE_WALK_RIGHT);
        aaah = (state == STATE_FALL_LEFT || state == STATE_FALL_RIGHT);
    end

endmodule
