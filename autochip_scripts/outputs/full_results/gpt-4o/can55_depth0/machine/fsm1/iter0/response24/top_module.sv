module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // State encoding
    parameter A = 1'b0, B = 1'b1;
    reg state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            A: if (in) next_state = A;
                else next_state = B;
            B: if (in) next_state = B;
                else next_state = A;
            default: next_state = B;  // Default to state B
        endcase
    end

    // State update logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= B;  // Reset state to B
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (state)
            B: out = 1'b1;
            default: out = 1'b0;
        endcase
    end
endmodule
