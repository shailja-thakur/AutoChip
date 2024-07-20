module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);
    reg [1:0] state;
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b10;  // Initialize state to walk_left
        else begin
            case (state)
                2'b00: begin  // State walk_left
                    if (bump_right)
                        state <= 2'b01;  // Switch to state walk_right
                    else if (bump_left || (bump_left && bump_right))
                        state <= 2'b10;  // Stay in state walk_left or switch to state walk_left
                end
                2'b01: begin  // State walk_right
                    if (bump_left)
                        state <= 2'b10;  // Switch to state walk_left
                    else if (bump_left && bump_right)
                        state <= 2'b10;  // Stay in state walk_right or switch to state walk_left
                end
            endcase
        end
    end
    
    assign walk_left = (state == 2'b10);
    assign walk_right = (state == 2'b01);
endmodule
