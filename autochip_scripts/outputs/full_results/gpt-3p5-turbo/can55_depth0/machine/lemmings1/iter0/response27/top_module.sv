module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

    // State definition
    parameter WL = 1;
    parameter WR = 0;
    
    // Registers
    reg state, next_state;
    
    always @(posedge clk or posedge areset)
    begin
        if (areset)
            state <= WL;
        else
            state <= next_state;
    end
    
    always @(*)
    begin
        if (state == WL)
        begin
            next_state = (bump_left == 1) ? WR : WL;
            walk_left = 1;
            walk_right = 0;
        end
        else // state == WR
        begin
            next_state = (bump_right == 1) ? WL : WR;
            walk_left = 0;
            walk_right = 1;
        end
    end

endmodule
