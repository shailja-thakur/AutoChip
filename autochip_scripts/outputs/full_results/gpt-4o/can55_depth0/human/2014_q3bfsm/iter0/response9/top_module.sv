module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    // State encoding
    typedef enum logic [2:0] {
        S0 = 3'd0,  // State 000
        S1 = 3'd1,  // State 001
        S2 = 3'd2,  // State 010
        S3 = 3'd3,  // State 011
        S4 = 3'd4   // State 100
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            S0: next_state = x ? S1 : S0;
            S1: next_state = x ? S4 : S1;
            S2: next_state = x ? S1 : S2;
            S3: next_state = x ? S2 : S1;
            S4: next_state = x ? S4 : S3;
            default: next_state = S0;
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            S3: z = 1;
            S4: z = 1;
            default: z = 0;
        endcase
    end

    // State registers
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

endmodule
