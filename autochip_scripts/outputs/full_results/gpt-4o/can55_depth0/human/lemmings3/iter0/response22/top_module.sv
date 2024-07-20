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

    typedef enum logic [2:0] {
        STATE_WALK_LEFT,
        STATE_WALK_RIGHT,
        STATE_FALL_LEFT,
        STATE_FALL_RIGHT,
        STATE_DIG_LEFT,
        STATE_DIG_RIGHT
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            STATE_WALK_LEFT: begin
                if (~ground) next_state = STATE_FALL_LEFT;
                else if (dig) next_state = STATE_DIG_LEFT;
                else if (bump_left) next_state = STATE_WALK_RIGHT;
                else next_state = STATE_WALK_LEFT;
            end
            STATE_WALK_RIGHT: begin
                if (~ground) next_state = STATE_FALL_RIGHT;
                else if (dig) next_state = STATE_DIG_RIGHT;
                else if (bump_right) next_state = STATE_WALK_LEFT;
                else next_state = STATE_WALK_RIGHT;
            end
            STATE_FALL_LEFT: begin
                if (ground) next_state = STATE_WALK_LEFT;
                else next_state = STATE_FALL_LEFT;
            end
            STATE_FALL_RIGHT: begin
                if (ground) next_state = STATE_WALK_RIGHT;
                else next_state = STATE_FALL_RIGHT;
            end
            STATE_DIG_LEFT: begin
                if (~ground) next_state = STATE_FALL_LEFT;
                else next_state = STATE_DIG_LEFT;
            end
            STATE_DIG_RIGHT: begin
                if (~ground) next_state = STATE_FALL_RIGHT;
                else next_state = STATE_DIG_RIGHT;
            end
            default: next_state = STATE_WALK_LEFT;
        endcase
    end

    // State update logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= STATE_WALK_LEFT;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        walk_left = (current_state == STATE_WALK_LEFT);
        walk_right = (current_state == STATE_WALK_RIGHT);
        aaah = (current_state == STATE_FALL_LEFT) || (current_state == STATE_FALL_RIGHT);
        digging = (current_state == STATE_DIG_LEFT) || (current_state == STATE_DIG_RIGHT);
    end

endmodule
