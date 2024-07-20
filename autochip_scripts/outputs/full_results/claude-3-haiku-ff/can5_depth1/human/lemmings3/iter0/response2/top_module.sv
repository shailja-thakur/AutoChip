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
localparam STATE_FALLING = 2;
localparam STATE_DIGGING = 3;

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
    end
end

always @(*) begin
    next_state = state;
    case (state)
        STATE_WALK_LEFT: begin
            walk_left = 1;
            walk_right = 0;
            aaah = 0;
            digging = 0;
            if (bump_right) begin
                next_state = STATE_WALK_RIGHT;
            end
            else if (!ground) begin
                next_state = STATE_FALLING;
            end
            else if (dig) begin
                next_state = STATE_DIGGING;
            end
        end
        STATE_WALK_RIGHT: begin
            walk_left = 0;
            walk_right = 1;
            aaah = 0;
            digging = 0;
            if (bump_left) begin
                next_state = STATE_WALK_LEFT;
            end
            else if (!ground) begin
                next_state = STATE_FALLING;
            end
            else if (dig) begin
                next_state = STATE_DIGGING;
            end
        end
        STATE_FALLING: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 1;
            digging = 0;
            if (ground) begin
                if (state == STATE_WALK_LEFT) begin
                    next_state = STATE_WALK_LEFT;
                end
                else begin
                    next_state = STATE_WALK_RIGHT;
                end
            end
        end
        STATE_DIGGING: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 0;
            digging = 1;
            if (!ground) begin
                next_state = STATE_FALLING;
            end
        end
    endcase
end

endmodule
