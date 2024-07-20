module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);
    // State encoding
    parameter WL = 1'b0, WR = 1'b1;
    
    // State register
    reg state, next_state;
    
    // Combinational logic for next state
    always @(*) begin
        // Default next state
        next_state = state;
        
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
        endcase
    end
    
    // Sequential logic for state update
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= WL;
        else
            state <= next_state;
    end
    
    // Output logic based on current state
    assign walk_left = (state == WL);
    assign walk_right = (state == WR);

endmodule
