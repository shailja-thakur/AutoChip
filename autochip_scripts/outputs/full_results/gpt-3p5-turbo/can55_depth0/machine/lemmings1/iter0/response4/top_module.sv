module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

parameter WL = 1; // State for walking left
parameter WR = 0; // State for walking right

reg state; // Register to store current state

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= WL; // Reset state to WL
    else
        case (state)
            WL: state <= (bump_left) ? WR : WL; // Next state is WR if bump_left is high, otherwise WL
            WR: state <= (bump_right) ? WL : WR; // Next state is WL if bump_right is high, otherwise WR
        endcase
end

assign walk_left = (state == WL) ? 1'b1 : 1'b0; // walk_left is high if state is WL, otherwise low
assign walk_right = (state == WR) ? 1'b1 : 1'b0; // walk_right is high if state is WR, otherwise low

endmodule
