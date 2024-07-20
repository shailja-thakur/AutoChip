module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // State encoding
    typedef enum logic [1:0] {
        S_A = 2'b00,
        S_B = 2'b01,
        S_C = 2'b10,
        S_D = 2'b11
    } state_t;
    
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case(state)
            S_A: next_state = (in) ? S_B : S_A;
            S_B: next_state = (in) ? S_B : S_C;
            S_C: next_state = (in) ? S_D : S_A;
            S_D: next_state = (in) ? S_B : S_C;
            default: next_state = S_A; // Default to avoid latches
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= S_A;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        case(state)
            S_A, S_B, S_C: out = 1'b0;
            S_D: out = 1'b1;
            default: out = 1'b0; // Default to avoid latches
        endcase
    end

endmodule
