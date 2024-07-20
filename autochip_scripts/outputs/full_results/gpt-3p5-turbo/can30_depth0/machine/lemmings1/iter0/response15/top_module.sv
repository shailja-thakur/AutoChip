module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);
    
    reg state;
    
    parameter WL = 1'b0; // Walking Left state
    parameter WR = 1'b1; // Walking Right state
    
    always @(posedge clk) begin
        if (areset) begin
            state <= WL; // Reset to Walking Left state
        end else begin
            if (state == WL) begin
                if (bump_left) begin
                    state <= WR; // Transition to Walking Right state
                end
            end else if (state == WR) begin
                if (bump_right) begin
                    state <= WL; // Transition to Walking Left state
                end
            end // else: Stay in current state
        end
    end
    
    assign walk_left = (state == WL) ? 1'b1 : 1'b0;
    assign walk_right = (state == WR) ? 1'b1 : 1'b0;
    
endmodule
