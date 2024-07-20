module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);
    
    // Parameter declarations
    parameter WL = 0;
    parameter WR = 1;
    
    // State register declaration
    reg [1:0] state;
    
    // Assign walk_left and walk_right outputs based on state
    assign walk_left = (state == WL) ? 1'b1 : 1'b0;
    assign walk_right = (state == WL) ? 1'b0 : 1'b1;
    
    // Combinational logic block to determine next state
    always @ (posedge clk or posedge areset) begin
        if (areset) begin
            state <= WL;
        end else begin
            if (state == WL) begin
                if (bump_left) begin
                    state <= WR;
                end else begin
                    state <= WL;
                end
            end else begin
                if (bump_right) begin
                    state <= WL;
                end else begin
                    state <= WR;
                end
            end
        end
    end
    
endmodule
