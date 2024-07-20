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

reg [4:0] fall_counter;

localparam [2:0]
    WALK_LEFT = 3'b000,
    WALK_RIGHT = 3'b001,
    FALL = 3'b010,
    DIGGING = 3'b011,
    SPLATTER = 3'b100;

reg [2:0] state, next_state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
        fall_counter <= 0;
    end
    else begin
        state <= next_state;
        walk_left <= (state == WALK_LEFT);
        walk_right <= (state == WALK_RIGHT);
        aaah <= (state == FALL);
        digging <= (state == DIGGING);
        if (state == FALL)
            fall_counter <= fall_counter + 1;
        else
            fall_counter <= 0;
    end
end

always @(*) begin
    next_state = state;
    case (state)
        WALK_LEFT:
            if (bump_right)
                next_state = WALK_RIGHT;
            else if (!ground)
                next_state = FALL;
            else if (dig)
                next_state = DIGGING;
        WALK_RIGHT:
            if (bump_left)
                next_state = WALK_LEFT;
            else if (!ground)
                next_state = FALL;
            else if (dig)
                next_state = DIGGING;
        FALL:
            if (ground)
                next_state = (walk_left) ? WALK_LEFT : WALK_RIGHT;
            else if (fall_counter == 20)
                next_state = SPLATTER;
        DIGGING:
            if (!ground)
                next_state = FALL;
        SPLATTER:
            next_state = SPLATTER;
    endcase
end

endmodule
