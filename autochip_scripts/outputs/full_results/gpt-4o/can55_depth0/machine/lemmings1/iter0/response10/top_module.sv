module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);
    // State Declaration
    parameter WL = 1'b0, WR = 1'b1;
    reg state, next_state;

    // Combinational Logic to Determine Next State
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

    // State Register Update on Clock Edge or Asynchronous Reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= WL;
        else
            state <= next_state;
    end

    // Output Logic Based on Current State
    assign walk_left = (state == WL);
    assign walk_right = (state == WR);

endmodule
