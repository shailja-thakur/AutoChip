module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    // Define the states
    parameter WL = 1'b0; // Walk left state
    parameter WR = 1'b1; // Walk right state

    // Current state register
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
            default: next_state = WL;
        endcase
    end

    // State register (synchronous)
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= WL; // Reset to the walking left state
        else
            state <= next_state;
    end

    // Output logic (combinational)
    always @(*) begin
        walk_left = (state == WL);
        walk_right = (state == WR);
    end

endmodule
