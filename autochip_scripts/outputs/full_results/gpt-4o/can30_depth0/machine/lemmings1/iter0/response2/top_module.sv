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
    reg state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            WL: if (bump_left) 
                    next_state = WR;
                else 
                    next_state = WL;
            WR: if (bump_right)
                    next_state = WL;
                else
                    next_state = WR;
            default: next_state = WL; // Default state
        endcase
    end

    // State flip-flops (sequential)
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= WL;    // Reset to initial state
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        walk_left = (state == WL);
        walk_right = (state == WR);
    end

endmodule
