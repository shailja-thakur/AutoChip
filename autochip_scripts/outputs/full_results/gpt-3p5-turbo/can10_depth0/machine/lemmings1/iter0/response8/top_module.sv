module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

parameter WL = 0;
parameter WR = 1;

reg state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WL;
    end else begin
        if (state == WL) begin
            state <= (bump_left) ? WR : WL;
        end else begin
            state <= (bump_right) ? WL : WR;
        end
    end
end

always @* begin
    walk_left = (state == WL);
    walk_right = (state == WR);
end

endmodule
