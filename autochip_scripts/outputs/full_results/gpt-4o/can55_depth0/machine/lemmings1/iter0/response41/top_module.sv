module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);
    
    // State encoding
    parameter WL = 1'b0, WR = 1'b1;
    
    // State register
    reg state, next_state;

    // Sequential block: Flip-flop to update state
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= WL; // Reset state to WL
        else
            state <= next_state; // Update state
    end

    // Combinational block: Next state logic
    always @(*) begin
        case (state)
            WL: begin
                if (bump_left)
                    next_state = WR; // Go to WR if bump_left is high
                else
                    next_state = WL; // Stay in WL if bump_left is low
            end
            WR: begin
                if (bump_right)
                    next_state = WL; // Go to WL if bump_right is high
                else
                    next_state = WR; // Stay in WR if bump_right is low
            end
            default: next_state = WL; // Default to WL (safety)
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            WL: begin
                walk_left = 1;
                walk_right = 0;
            end
            WR: begin
                walk_left = 0;
                walk_right = 1;
            end
            default: begin
                walk_left = 1;
                walk_right = 0;
            end // Default state match WL for safety
        endcase
    end

endmodule
