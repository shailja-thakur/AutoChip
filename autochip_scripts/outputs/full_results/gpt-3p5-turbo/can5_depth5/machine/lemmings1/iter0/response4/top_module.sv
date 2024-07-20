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
    if (areset) begin
        state <= WL;
    end else begin
        state <= next_state;
    end
end

always @* begin
    if (state == WL) begin
        if (bump_left) begin
            next_state = WR;
        end else begin
            next_state = WL;
        end
    end else begin
        if (bump_right) begin
            next_state = WL;
        end else begin
            next_state = WR;
        end
    end
end

assign walk_left = (state == WL) ? 1'b1 : 1'b0;
assign walk_right = (state == WR) ? 1'b1 : 1'b0;

endmodule
