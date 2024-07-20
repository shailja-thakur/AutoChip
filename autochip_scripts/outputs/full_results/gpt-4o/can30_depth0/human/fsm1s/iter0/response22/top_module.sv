module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define state encoding
    typedef enum reg [0:0] {A = 1'b0, B = 1'b1} state_t;
    state_t state, next_state;

    // State transition logic
    always @* begin
        case (state)
            B: if (in) next_state = B; else next_state = A;
            A: if (in) next_state = A; else next_state = B;
            default: next_state = B; // Default state is B
        endcase
    end

    // State flip-flops with synchronous reset
    always @(posedge clk) begin
        if (reset)
            state <= B; // Reset state
        else
            state <= next_state;
    end

    // Output logic based on state
    always @* begin
        case (state)
            B: out = 1;
            A: out = 0;
            default: out = 1; // Default output
        endcase
    end

endmodule
