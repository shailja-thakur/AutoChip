module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    // State encoding
    reg state, next_state;
    localparam S_LEFT = 1'b0, S_RIGHT = 1'b1;

    // Sequential logic for state transition
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= S_LEFT;
        else
            state <= next_state;
    end

    // Combinational logic for next state
    always @(*) begin
        case (state)
            S_LEFT: begin
                if (bump_left)
                    next_state = S_RIGHT;
                else
                    next_state = S_LEFT;
            end

            S_RIGHT: begin
                if (bump_right)
                    next_state = S_LEFT;
                else
                    next_state = S_RIGHT;
            end

            default: next_state = S_LEFT;
        endcase
    end

    // Output logic based on state
    always @(*) begin
        case (state)
            S_LEFT: begin
                walk_left = 1'b1;
                walk_right = 1'b0;
            end

            S_RIGHT: begin
                walk_left = 1'b0;
                walk_right = 1'b1;
            end

            default: begin
                walk_left = 1'b1;
                walk_right = 1'b0;
            end
        endcase
    end

endmodule
