module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

parameter WL = 0;  // State WL
parameter WR = 1;  // State WR

reg state;         // State register

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= WL;    // Reset to initial state WL
    else if (state == WL)
        state <= (bump_left) ? WR : WL;    // Transition logic for state WL
    else if (state == WR)
        state <= (bump_right) ? WL : WR;   // Transition logic for state WR
end

assign walk_left = (state == WL) ? 1'b1 : 1'b0;    // Assign output walk_left based on current state
assign walk_right = (state == WR) ? 1'b1 : 1'b0;   // Assign output walk_right based on current state

endmodule
