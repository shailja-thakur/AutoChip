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
        STATE_WALK_LEFT = 3'b000,
        STATE_WALK_RIGHT = 3'b001,
        STATE_FALL_LEFT = 3'b010,
        STATE_FALL_RIGHT = 3'b011,
        STATE_DIG_LEFT = 3'b100,
        STATE_DIG_RIGHT = 3'b101
    } state_t;

    state_t state, next_state;

    always @(*) begin
        case(state)
            STATE_WALK_LEFT: begin
                if (!ground) begin
                    next_state = STATE_FALL_LEFT;
                end else if (dig) begin
                    next_state = STATE_DIG_LEFT;
                end else if (bump_left) begin
                    next_state = STATE_WALK_RIGHT;
                end else begin
                    next_state = STATE_WALK_LEFT;
                end
            end
            STATE_WALK_RIGHT: begin
                if (!ground) begin
                    next_state = STATE_FALL_RIGHT;
                end else if (dig) begin
                    next_state = STATE_DIG_RIGHT;
                end else if (bump_right) begin
                    next_state = STATE_WALK_LEFT;
                end else begin
                    next_state = STATE_WALK_RIGHT;
                end
            end
            STATE_FALL_LEFT, STATE_FALL_RIGHT: begin
                if (ground) begin
                    if (state == STATE_FALL_LEFT)
                        next_state = STATE_WALK_LEFT;
                    else
                        next_state = STATE_WALK_RIGHT;
                end else begin
                    next_state = state;
                end
            end
            STATE_DIG_LEFT: begin
                if (!ground) begin
                    next_state = STATE_FALL_LEFT;
                end else begin
                    next_state = STATE_DIG_LEFT;
                end
            end
            STATE_DIG_RIGHT: begin
                if (!ground) begin
                    next_state = STATE_FALL_RIGHT;
                end else begin
                    next_state = STATE_DIG_RIGHT;
                end
            end
            default: next_state = STATE_WALK_LEFT; 
        endcase
    end

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_WALK_LEFT;
        end else begin
            state <= next_state;
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
            STATE_FALL_LEFT, STATE_FALL_RIGHT: aaah = 1;
            STATE_DIG_LEFT, STATE_DIG_RIGHT: digging = 1;
        endcase
    end

endmodule
