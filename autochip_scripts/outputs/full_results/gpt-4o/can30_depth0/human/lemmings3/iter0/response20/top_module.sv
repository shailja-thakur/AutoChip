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

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_WALK_LEFT;
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        next_state = current_state; // Default state transition
        case (current_state)
            STATE_WALK_LEFT: begin
                if (!ground) begin
                    next_state = STATE_FALL_LEFT;
                end else if (dig) begin
                    next_state = STATE_DIG_LEFT;
                end else if (bump_left) begin
                    next_state = STATE_WALK_RIGHT;
                end
            end
            STATE_WALK_RIGHT: begin
                if (!ground) begin
                    next_state = STATE_FALL_RIGHT;
                end else if (dig) begin
                    next_state = STATE_DIG_RIGHT;
                end else if (bump_right) begin
                    next_state = STATE_WALK_LEFT;
                end
            end
            STATE_FALL_LEFT: begin
                if (ground) begin
                    next_state = STATE_WALK_LEFT;
                end
            end
            STATE_FALL_RIGHT: begin
                if (ground) begin
                    next_state = STATE_WALK_RIGHT;
                end
            end
            STATE_DIG_LEFT: begin
                if (!ground) begin
                    next_state = STATE_FALL_LEFT;
                end
            end
            STATE_DIG_RIGHT: begin
                if (!ground) begin
                    next_state = STATE_FALL_RIGHT;
                end
            end
        endcase
    end

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
        end else begin
            walk_left <= (next_state == STATE_WALK_LEFT);
            walk_right <= (next_state == STATE_WALK_RIGHT);
            aaah <= (next_state == STATE_FALL_LEFT || next_state == STATE_FALL_RIGHT);
            digging <= (next_state == STATE_DIG_LEFT || next_state == STATE_DIG_RIGHT);
        end
    end

endmodule
