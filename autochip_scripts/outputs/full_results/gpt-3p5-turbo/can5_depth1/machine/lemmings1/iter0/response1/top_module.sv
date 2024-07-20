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
assign next_state = (state == WL && bump_right) ? WR :
                  (state == WR && bump_left) ? WL :
                  state;
                  
always @(posedge clk or posedge areset) begin
    if (areset)
        state <= WL;
    else
        state <= next_state;
end

assign walk_left = (state == WL) ? 1'b1 : 1'b0;
assign walk_right = (state == WR) ? 1'b1 : 1'b0;

endmodule
