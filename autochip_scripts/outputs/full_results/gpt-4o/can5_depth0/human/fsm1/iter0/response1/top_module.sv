module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // State Encoding
    typedef enum logic {A, B} state_t;
    state_t state, next_state;

    // State Transition Logic (Combinational)
    always @(*) begin
        case (state)
            A: if (in) next_state = A; else next_state = B;
            B: if (in) next_state = B; else next_state = A;
            default: next_state = B;  // Default to state B
        endcase
    end

    // State Register Logic (Sequential)
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= B;
        else
            state <= next_state;
    end

    // Output Logic (Moore Machine: Output is only dependent on state)
    always @(*) begin
        case (state)
            A: out = 0;
            B: out = 1;
            default: out = 1;  // Default to state B's output
        endcase
    end

endmodule
