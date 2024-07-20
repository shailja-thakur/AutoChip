module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    typedef enum reg {A, B} state_t;
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case(state)
            A: next_state = in ? A : B;
            B: next_state = in ? B : A;
            default: next_state = B; // default to avoid latches, although it shouldn't be necessary
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= B;
        else
            state <= next_state;
    end

    // Output logic
    assign out = (state == B);

endmodule
