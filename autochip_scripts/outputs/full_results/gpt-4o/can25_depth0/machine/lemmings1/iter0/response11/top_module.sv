module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);
    
    // Define the parameters for the states
    parameter WL = 1'b0;  // Walk Left state
    parameter WR = 1'b1;  // Walk Right state
    
    // State register
    reg state;
    reg next_state;
    
    // Combinational logic for next state
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
            default: next_state = WL;
        endcase
    end
    
    // Sequential logic for state transition
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= WL;
        else
            state <= next_state;
    end
    
    // Output logic
    always @(*) begin
        walk_left = (state == WL);
        walk_right = (state == WR);
    end
endmodule
