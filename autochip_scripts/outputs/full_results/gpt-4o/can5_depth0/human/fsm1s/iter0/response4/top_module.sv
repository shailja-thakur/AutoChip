module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State Encoding
    typedef enum reg [1:0] { A = 2'b00, B = 2'b01 } state_t;
    state_t state, next_state;

    // Output Logic
    always @(state) begin
        case(state)
            B: out = 1;
            A: out = 0;
            default: out = 1;  // default to prevent latches
        endcase
    end

    // Next State Logic
    always @(state, in) begin
        case(state)
            B: next_state = (in) ? B : A;
            A: next_state = (in) ? A : B;
            default: next_state = B;  // default to prevent latches
        endcase
    end

    // State Transition
    always @(posedge clk) begin
        if (reset)
            state <= B;
        else
            state <= next_state;
    end

endmodule
