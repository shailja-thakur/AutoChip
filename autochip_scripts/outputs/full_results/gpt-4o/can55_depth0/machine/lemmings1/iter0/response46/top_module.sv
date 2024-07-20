module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);
    // Parameter definitions for states
    parameter WL = 1'b0, WR = 1'b1;
    
    // Register to hold the current state
    reg state, next_state;
    
    // Combinational logic to determine next state
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
        endcase
    end

    // Sequential logic to update state
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
