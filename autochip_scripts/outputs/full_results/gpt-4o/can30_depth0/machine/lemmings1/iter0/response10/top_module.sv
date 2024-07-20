module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

    // Define states as parameters
    parameter WL = 1'b0; // Walking Left state
    parameter WR = 1'b1; // Walking Right state
    
    // State register
    reg state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            WL: begin
                if (bump_left) 
                    next_state = WR;
                else 
                    next_state = WL;
            end
            WR: begin
                if (bump_right) 
                    next_state = WL;
                else 
                    next_state = WR;
            end
            default: next_state = WL; // Default to WL state
        endcase
    end

    // State register update logic (sequential)
    always @(posedge clk or posedge areset) begin
        if (areset) 
            state <= WL; // Reset to WL state
        else 
            state <= next_state; // Update state
    end

    // Output logic
    assign walk_left = (state == WL);
    assign walk_right = (state == WR);

endmodule
