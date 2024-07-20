module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

parameter WL = 1;
parameter WR = 0;

reg state;
wire next_state;

// Combinational logic block to determine the next state
always @ (posedge clk or posedge areset) begin
    if (areset)
        state <= WL;
    else begin
        if (state == WL)
            state <= (bump_left) ? WR : WL;
        else if (state == WR)
            state <= (bump_right) ? WL : WR;
    end
end

// Assigning the walk_left and walk_right outputs based on the current state
assign walk_left = (state == WL) ? 1'b1 : 1'b0;
assign walk_right = (state == WL) ? 1'b0 : 1'b1;

endmodule
