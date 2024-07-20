module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	output walk_left,
	output walk_right
);
    
    // parameters for state machine states
    parameter WL = 1'b0;
    parameter WR = 1'b1;
    
    // register to store current state
    reg state;
    
    // combinational logic block to compute next state
    always @ (posedge clk or posedge areset)
    begin
        if (areset)
            state <= WL;
        else if (state == WL)
            state <= (bump_left) ? WR : WL;
        else if (state == WR)
            state <= (bump_right) ? WL : WR;
        else
            state <= WL;
    end
    
    // output assignment based on current state
    assign walk_left = (state == WL) ? 1'b1 : 1'b0;
    assign walk_right = (state == WR) ? 1'b1 : 1'b0;
        
endmodule
