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

localparam [2:0] 
    STATE_WALK_LEFT = 3'b000,
    STATE_WALK_RIGHT = 3'b001,
    STATE_FALL = 3'b010,
    STATE_DIG = 3'b011;

reg [2:0] state, next_state;
reg [4:0] fall_count;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
        fall_count <= 0;
    end
    else begin
        state <= next_state;
        walk_left <= (state == STATE_WALK_LEFT);
        walk_right <= (state == STATE_WALK_RIGHT);
        aaah <= (state == STATE_FALL);
        digging <= (state == STATE_DIG);
        if (state == STATE_FALL)
            fall_count <= fall_count + 1;
        else
            fall_count <= 0;
    end
end

always @(*) begin
    next_state = state;
    case (state)
        STATE_WALK_LEFT:
            if (bump_right)
                next_state = STATE_WALK_RIGHT;
            else if (!ground)
                next_state = STATE_FALL;
            else if (dig)
                next_state = STATE_DIG;
        STATE_WALK_RIGHT:
            if (bump_left)
                next_state = STATE_WALK_LEFT;
            else if (!ground)
                next_state = STATE_FALL;
            else if (dig)
                next_state = STATE_DIG;
        STATE_FALL:
            if (ground)
                next_state = (walk_left) ? STATE_WALK_LEFT : STATE_WALK_RIGHT;
        STATE_DIG:
            if (!ground)
                next_state = STATE_FALL;
            else if (!dig)
                next_state = (walk_left) ? STATE_WALK_LEFT : STATE_WALK_RIGHT;
    endcase

    if (fall_count >= 20 && !ground)
        next_state = STATE_WALK_LEFT;
end

endmodule
