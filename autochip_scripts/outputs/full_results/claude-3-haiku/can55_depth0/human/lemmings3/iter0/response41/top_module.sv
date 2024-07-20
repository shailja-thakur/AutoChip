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

localparam STATE_WALK_LEFT = 0;
localparam STATE_WALK_RIGHT = 1;
localparam STATE_FALL = 2;
localparam STATE_DIG = 3;

reg [1:0] state, next_state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= STATE_WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
    end
    else begin
        state <= next_state;
        walk_left <= (state == STATE_WALK_LEFT);
        walk_right <= (state == STATE_WALK_RIGHT);
        aaah <= (state == STATE_FALL);
        digging <= (state == STATE_DIG);
    end
end

always @(*) begin
    next_state = state;
    case (state)
        STATE_WALK_LEFT: begin
            if (bump_right) begin
                next_state = STATE_WALK_RIGHT;
            end
            else if (!ground) begin
                next_state = STATE_FALL;
            end
            else if (dig) begin
                next_state = STATE_DIG;
            end
        end
        STATE_WALK_RIGHT: begin
            if (bump_left) begin
                next_state = STATE_WALK_LEFT;
            end
            else if (!ground) begin
                next_state = STATE_FALL;
            end
            else if (dig) begin
                next_state = STATE_DIG;
            end
        end
        STATE_FALL: begin
            if (ground) begin
                if (walk_left) begin
                    next_state = STATE_WALK_LEFT;
                end
                else begin
                    next_state = STATE_WALK_RIGHT;
                end
            end
        end
        STATE_DIG: begin
            if (!ground) begin
                next_state = STATE_FALL;
            end
        end
    endcase
end

endmodule
