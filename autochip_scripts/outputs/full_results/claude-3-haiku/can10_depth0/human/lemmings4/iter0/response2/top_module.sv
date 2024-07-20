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

localparam [1:0] WALK_LEFT = 2'b00, WALK_RIGHT = 2'b01, FALLING = 2'b10, DIGGING = 2'b11;
reg [1:0] state, next_state;
reg [4:0] fall_count;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
        fall_count <= 0;
    end
    else begin
        state <= next_state;
        walk_left <= (state == WALK_LEFT);
        walk_right <= (state == WALK_RIGHT);
        aaah <= (state == FALLING);
        digging <= (state == DIGGING);
        if (state == FALLING)
            fall_count <= fall_count + 1;
        else
            fall_count <= 0;
    end
end

always @(*) begin
    case (state)
        WALK_LEFT: begin
            if (bump_right)
                next_state = WALK_RIGHT;
            else if (!ground)
                next_state = FALLING;
            else if (dig)
                next_state = DIGGING;
            else
                next_state = WALK_LEFT;
        end
        WALK_RIGHT: begin
            if (bump_left)
                next_state = WALK_LEFT;
            else if (!ground)
                next_state = FALLING;
            else if (dig)
                next_state = DIGGING;
            else
                next_state = WALK_RIGHT;
        end
        FALLING: begin
            if (ground)
                next_state = (walk_left) ? WALK_LEFT : WALK_RIGHT;
            else
                next_state = FALLING;
        end
        DIGGING: begin
            if (!ground)
                next_state = FALLING;
            else
                next_state = DIGGING;
        end
        default:
            next_state = WALK_LEFT;
    endcase

    if (fall_count >= 20 && !ground)
        next_state = WALK_LEFT;
end

endmodule
