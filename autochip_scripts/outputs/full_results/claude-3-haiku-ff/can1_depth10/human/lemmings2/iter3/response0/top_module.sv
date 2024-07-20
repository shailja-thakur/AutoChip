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

localparam LEFT = 1'b0, RIGHT = 1'b1;
reg state, next_state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
    end
    else begin
        state <= next_state;
        walk_left <= (state == LEFT) ? 1 : 0;
        walk_right <= (state == RIGHT) ? 1 : 0;
        aaah <= (ground == 1'b0) ? 1 : 0;
    end
end

always @(*) begin
    next_state = state;
    if (ground == 1'b0) begin
        // Falling, do not change direction
        next_state = state;
    end
    else if (bump_left == 1'b1) begin
        next_state = RIGHT;
    end
    else if (bump_right == 1'b1) begin
        next_state = LEFT;
    end
    else begin
        // No bumps, continue in the same direction
        next_state = state;
    end
end

endmodule
