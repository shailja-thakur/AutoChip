module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding
    localparam S0 = 1'b0;  // Initial state
    localparam S1 = 1'b1;  // Complementing state

    reg state, next_state;

    // State transition logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= S0;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            S0: next_state = x ? S1 : S0;
            S1: next_state = S1;
            default: next_state = S0;
        endcase
    end

    // Output logic
    always @(*) begin
        case(state)
            S0: z = x;          // Output same as input in initial state
            S1: z = ~x;         // Invert the bit
            default: z = x;
        endcase
    end

endmodule
