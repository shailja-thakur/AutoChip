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

parameter WALK_LEFT = 2'b00, WALK_RIGHT = 2'b01, FALL = 2'b10, DIG = 2'b11;
reg [1:0] state, next_state;

always @(posedge clk, posedge areset) begin
    if (areset)
        state <= WALK_LEFT;
    else
        state <= next_state;
end

always @(*) begin
    next_state = state;
    walk_left = 0;
    walk_right = 0;
    aaah = 0;
    digging = 0;

    case (state)
        WALK_LEFT: begin
            walk_left = 1;
            if (bump_right)
                next_state = WALK_RIGHT;
            else if (!ground)
                next_state = FALL;
            else if (dig)
                next_state = DIG;
        end
        WALK_RIGHT: begin
            walk_right = 1;
            if (bump_left)
                next_state = WALK_LEFT;
            else if (!ground)
                next_state = FALL;
            else if (dig)
                next_state = DIG;
        end
        FALL: begin
            aaah = 1;
            if (ground)
                next_state = state == WALK_LEFT ? WALK_LEFT : WALK_RIGHT;
        end
        DIG: begin
            digging = 1;
            if (!ground)
                next_state = FALL;
            else if (!dig)
                next_state = state == WALK_LEFT ? WALK_LEFT : WALK_RIGHT;
        end
    endcase
end

endmodule
