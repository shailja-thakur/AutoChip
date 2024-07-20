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

    typedef enum {
        STATE_WALK_LEFT,
        STATE_WALK_RIGHT,
        STATE_FALL_LEFT,
        STATE_FALL_RIGHT,
        STATE_DIG_LEFT,
        STATE_DIG_RIGHT,
        STATE_SPLAT
    } state_t;
    
    reg [5:0] fall_count;
    state_t state, next_state;

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
                    if (fall_count >= 20)
                        next_state = STATE_SPLAT;
                    else
                        next_state = STATE_WALK_LEFT;
                else
                    next_state = STATE_FALL_LEFT;
            end
            STATE_FALL_RIGHT: begin
                if (ground)
                    if (fall_count >= 20)
                        next_state = STATE_SPLAT;
                    else
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
            STATE_SPLAT: begin
                next_state = STATE_SPLAT;
            end
            default: begin
                next_state = STATE_WALK_LEFT;
            end
        endcase
    end

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_WALK_LEFT;
            fall_count <= 0;
        end else begin
            state <= next_state;
            if (state == STATE_FALL_LEFT || state == STATE_FALL_RIGHT)
                fall_count <= fall_count + 1;
            else
                fall_count <= 0;
        end
    end

    always @(*) begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        case (state)
            STATE_WALK_LEFT: walk_left = 1;
            STATE_WALK_RIGHT: walk_right = 1;
            STATE_FALL_LEFT: aaah = 1;
            STATE_FALL_RIGHT: aaah = 1;
            STATE_DIG_LEFT: digging = 1;
            STATE_DIG_RIGHT: digging = 1;
        endcase
    end
endmodule
