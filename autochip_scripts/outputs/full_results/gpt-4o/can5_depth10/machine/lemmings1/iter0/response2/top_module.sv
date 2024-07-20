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

    // Combinational logic for the next state
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
            default: next_state = WL; // Default state should be handled
        endcase
    end

    // State register update logic
    always @(posedge clk or posedge areset) begin
        if (areset) 
            state <= WL; // Reset to initial state
        else
            state <= next_state;
    end

    // Output logic
    always @(state) begin
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
                walk_left = 0; // Default outputs should be handled
                walk_right = 0;
            end
        endcase
    end

endmodule
