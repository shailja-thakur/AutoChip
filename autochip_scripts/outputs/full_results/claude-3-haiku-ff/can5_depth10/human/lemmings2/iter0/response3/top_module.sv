module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output reg walk_left,
    output reg walk_right,
    output reg aaah
);

localparam [1:0]
    WALK_LEFT = 2'b00,
    WALK_RIGHT = 2'b01,
    FALLING = 2'b10;

reg [1:0] state, next_state;

always @(posedge clk, posedge areset) begin
    if (areset)
        state <= WALK_LEFT;
    else
        state <= next_state;
end

always @(*) begin
    next_state = state;
    case (state)
        WALK_LEFT: begin
            walk_left = 1'b1;
            walk_right = 1'b0;
            aaah = 1'b0;
            if (bump_right)
                next_state = WALK_RIGHT;
            else if (!ground)
                next_state = FALLING;
        end
        WALK_RIGHT: begin
            walk_left = 1'b0;
            walk_right = 1'b1;
            aaah = 1'b0;
            if (bump_left)
                next_state = WALK_LEFT;
            else if (!ground)
                next_state = FALLING;
        end
        FALLING: begin
            walk_left = 1'b0;
            walk_right = 1'b0;
            aaah = 1'b1;
            if (ground)
                next_state = state == WALK_LEFT ? WALK_LEFT : WALK_RIGHT;
        end
    endcase
end

endmodule
