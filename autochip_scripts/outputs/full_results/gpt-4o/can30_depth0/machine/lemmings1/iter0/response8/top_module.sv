module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    // State encoding
    parameter WL = 1'b0;
    parameter WR = 1'b1;

    // State register
    reg state, next_state;

    // Sequential logic for state transitions
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WL;  // Reset state to WL
        end else begin
            state <= next_state;  // Update state
        end
    end

    // Combinational logic for determining next state
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

    // Output logic based on current state
    always @(*) begin
        case (state)
            WL: begin
                walk_left = 1;
                walk_right = 0;
            end
            WR: begin
                walk_left = 0;
                walk_right = 1;
            end
        endcase
    end
endmodule
