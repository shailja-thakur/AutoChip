module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);
    // State encoding
    typedef enum reg {A, B} state_t;
    state_t state, next_state;

    // State Transition Logic
    always @(*) begin
        case (state)
            B: next_state = (in == 1'b0) ? A : B;
            A: next_state = (in == 1'b0) ? B : A;
            default: next_state = B; // Default to state B
        endcase
    end

    // State Register (Synchronous)
    always @(posedge clk) begin
        if (reset)
            state <= B;
        else
            state <= next_state;
    end

    // Output Logic
    always @(*) begin
        case (state)
            B: out = 1'b1;
            A: out = 1'b0;
            default: out = 1'b1; // Default output for safety
        endcase
    end
endmodule
