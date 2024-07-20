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

reg state;
reg next_state;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= WL;
    else
        state <= next_state;
end

always @* begin
    if (state == WL)
        next_state = (bump_left) ? WR : WL;
    else if (state == WR)
        next_state = (bump_right) ? WL : WR;
end

assign walk_left = (state == WL) ? 1'b1 : 1'b0;
assign walk_right = (state == WR) ? 1'b1 : 1'b0;

endmodule
