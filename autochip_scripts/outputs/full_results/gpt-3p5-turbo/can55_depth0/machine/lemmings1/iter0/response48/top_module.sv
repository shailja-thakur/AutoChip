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
wire next_state;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= WL;
    else
        state <= next_state;
end

always @* begin
    if (state == WL)
        next_state = (bump_left) ? WR : WL;
    else
        next_state = (bump_right) ? WL : WR;
end

assign walk_left = (state == WL);
assign walk_right = (state == WR);

endmodule
