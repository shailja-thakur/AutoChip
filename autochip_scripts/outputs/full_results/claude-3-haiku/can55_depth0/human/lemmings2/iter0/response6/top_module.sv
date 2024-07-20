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

parameter WALK_LEFT = 1'b0, WALK_RIGHT = 1'b1;
reg state, next_state;

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
            if (bump_right)
                next_state = WALK_RIGHT;
        end
        WALK_RIGHT: begin
            walk_left = 1'b0;
            walk_right = 1'b1;
            if (bump_left)
                next_state = WALK_LEFT;
        end
    endcase
end

always @(*) begin
    aaah = 1'b0;
    if (~ground)
        aaah = 1'b1;
end

endmodule
