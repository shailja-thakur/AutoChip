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
    WALK_LEFT,
    WALK_RIGHT,
    FALL,
    DIG_LEFT,
    DIG_RIGHT,
    FALL_DIG
} state_t;

state_t state, next_state;

// State transition logic (combinational)
always @(*) begin
    case (state)
        WALK_LEFT:
            if (!ground) next_state = FALL;
            else if (dig) next_state = DIG_LEFT;
            else if (bump_left) next_state = WALK_RIGHT;
            else next_state = WALK_LEFT;
        WALK_RIGHT:
            if (!ground) next_state = FALL;
            else if (dig) next_state = DIG_RIGHT;
            else if (bump_right) next_state = WALK_LEFT;
            else next_state = WALK_RIGHT;
        FALL:
            if (ground) begin
                if (state == FALL_DIG) next_state = (next_state == FALL_DIG_LEFT) ? DIG_LEFT : DIG_RIGHT;
                else next_state = (state == FALL_DIG) ? next_state : state;
            end else next_state = FALL;
        DIG_LEFT:
            if (!ground) next_state = FALL_DIG;
            else next_state = DIG_LEFT;
        DIG_RIGHT:
            if (!ground) next_state = FALL_DIG;
            else next_state = DIG_RIGHT;
        FALL_DIG:
            if (ground) next_state = (next_state == FALL_DIG_LEFT) ? DIG_LEFT : DIG_RIGHT;
            else next_state = FALL_DIG;
        default: next_state = WALK_LEFT;
    endcase
end

// State flip-flops (sequential)
always @(posedge clk or posedge areset) begin
    if (areset)
        state <= WALK_LEFT;
    else
        state <= next_state;
end

// Output logic (combinational)
always @(*) begin
    case (state)
        WALK_LEFT: begin
            walk_left = 1;
            walk_right = 0;
            aaah = 0;
            digging = 0;
        end
        WALK_RIGHT: begin
            walk_left = 0;
            walk_right = 1;
            aaah = 0;
            digging = 0;
        end
        FALL: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 1;
            digging = 0;
        end
        DIG_LEFT: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 0;
            digging = 1;
        end
        DIG_RIGHT: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 0;
            digging = 1;
        end
        FALL_DIG: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 1;
            digging = 0;
        end
        default: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 0;
            digging = 0;
        end
    endcase
end

endmodule
