module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

    reg [1:0] state; // State variable
    
    always @(posedge clk or posedge areset) begin
        if (areset == 1) begin
            state <= 2'b01; // Reset state to walk_left
        end else begin
            case (state)
                2'b01: begin
                    // Current state is walk_left
                    if (bump_right == 1) begin
                        state <= 2'b10; // Switch to walk_right state
                    end
                end
                2'b10: begin
                    // Current state is walk_right
                    if (bump_left == 1) begin
                        state <= 2'b01; // Switch to walk_left state
                    end
                end
            endcase
        end
    end
    
    // Outputs
    assign walk_left = (state == 2'b01);
    assign walk_right = (state == 2'b10);
    
endmodule
