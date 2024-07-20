module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
    );
    
    parameter WL = 1'b0;
    parameter WR = 1'b1;
    
    reg state;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= WL;
        else if (state == WL)
            state <= (bump_left) ? WR : WL;
        else if (state == WR)
            state <= (bump_right) ? WL : WR;
    end
    
    always @(posedge clk) begin
        walk_left <= (state == WL) ? 1'b1 : 1'b0;
        walk_right <= (state == WR) ? 1'b1 : 1'b0;
    end
    
endmodule
