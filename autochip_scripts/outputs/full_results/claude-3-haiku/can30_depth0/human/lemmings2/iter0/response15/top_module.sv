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

parameter WALK_LEFT = 1'b1, WALK_RIGHT = 1'b0;

reg state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= WALK_LEFT;
    else
        state <= next_state;
end

always @(*) begin
    // Default assignments
    walk_left = state;
    walk_right = ~state;
    aaah = 1'b0;
    next_state = state;

    // State transitions
    if (ground == 1'b0) begin
        aaah = 1'b1;
        next_state = state;
    end
    else if (bump_left == 1'b1) begin
        next_state = WALK_RIGHT;
    end
    else if (bump_right == 1'b1) begin
        next_state = WALK_LEFT;
    end
end

endmodule
