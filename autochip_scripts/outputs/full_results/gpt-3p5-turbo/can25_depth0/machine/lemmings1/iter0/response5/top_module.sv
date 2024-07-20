module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

parameter WL = 0;
parameter WR = 1;

reg state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= WL;
    else
        state <= next_state;
end

always @(*) begin
    if (state == WL)
        next_state = (bump_left) ? WR : WL;
    else if (state == WR)
        next_state = (bump_right) ? WL : WR;
end

always @(posedge clk) begin
    if (state == WL) begin
        walk_left = 1;
        walk_right = 0;
    end else if (state == WR) begin
        walk_left = 0;
        walk_right = 1;
    end
end

endmodule
