module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    // State Definitions
    parameter WL = 1'b0;
    parameter WR = 1'b1;

    // State Register
    reg state, next_state;

    // State Transition Logic
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
            default: next_state = WL;
        endcase
    end

    // State Register Update
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= WL;
        else
            state <= next_state;
    end

    // Output Logic
    always @(*) begin
        case (state)
            WL: begin
                walk_left = 1'b1;
                walk_right = 1'b0;
            end
            WR: begin
                walk_left = 1'b0;
                walk_right = 1'b1;
            end
            default: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
            end
        endcase
    end

endmodule
