module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding
    localparam S0 = 2'b00;  // Initial state
    localparam S1 = 2'b01;  // State after 1 is encountered (To start inverting)
    localparam S2 = 2'b10;  // State followed by inverting state (Hold state)

    reg [1:0] state, next_state;

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
            S1: next_state = S2;
            S2: next_state = S2;
            default: next_state = S0;
        endcase
    end

    // Output logic
    always @(*) begin
        case(state)
            S0: z = x;          // Output same as input in this state
            S1: z = ~x;         // Invert the bit
            S2: z = ~x;         // Continue inverting
            default: z = x;
        endcase
    end

endmodule
