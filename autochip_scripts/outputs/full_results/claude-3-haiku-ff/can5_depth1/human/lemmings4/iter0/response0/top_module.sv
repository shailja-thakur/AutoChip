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

localparam  STATE_WALK_LEFT  = 2'b00,
            STATE_WALK_RIGHT = 2'b01,
            STATE_FALL       = 2'b10,
            STATE_DIG        = 2'b11;

reg [1:0] state, next_state;
reg [4:0] fall_counter;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= STATE_WALK_LEFT;
        walk_left <= 1'b1;
        walk_right <= 1'b0;
        aaah <= 1'b0;
        digging <= 1'b0;
        fall_counter <= 5'b0;
    end
    else begin
        state <= next_state;
        walk_left <= (state == STATE_WALK_LEFT);
        walk_right <= (state == STATE_WALK_RIGHT);
        aaah <= (state == STATE_FALL);
        digging <= (state == STATE_DIG);
        if (state == STATE_FALL)
            fall_counter <= fall_counter + 1'b1;
        else
            fall_counter <= 5'b0;
    end
end

always @(*) begin
    case (state)
        STATE_WALK_LEFT: begin
            if (bump_right)
                next_state = STATE_WALK_RIGHT;
            else if (!ground)
                next_state = STATE_FALL;
            else if (dig && ground)
                next_state = STATE_DIG;
            else
                next_state = STATE_WALK_LEFT;
        end
        STATE_WALK_RIGHT: begin
            if (bump_left)
                next_state = STATE_WALK_LEFT;
            else if (!ground)
                next_state = STATE_FALL;
            else if (dig && ground)
                next_state = STATE_DIG;
            else
                next_state = STATE_WALK_RIGHT;
        end
        STATE_FALL: begin
            if (ground)
                next_state = (walk_left) ? STATE_WALK_LEFT : STATE_WALK_RIGHT;
            else
                next_state = STATE_FALL;
        end
        STATE_DIG: begin
            if (!ground)
                next_state = STATE_FALL;
            else
                next_state = STATE_DIG;
        end
        default:
            next_state = STATE_WALK_LEFT;
    endcase

    if (fall_counter >= 20 && !ground)
        next_state = STATE_WALK_LEFT;
end

endmodule
