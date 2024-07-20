module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);
    
    // States declaration
    parameter WL = 1'b0;
    parameter WR = 1'b1;

    // State register
    reg state, next_state;

    // Sequential logic for state transition
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= WL; // Reset to WL state
        else
            state <= next_state; // Transition to next state
    end

    // Combinational logic for next state determination
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
            default: next_state = WL; // default to WL state
        endcase
    end

    // Output logic based on current state
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
            default: begin // default output condition
                walk_left = 1'b0;
                walk_right = 1'b0;
            end
        endcase
    end

endmodule
