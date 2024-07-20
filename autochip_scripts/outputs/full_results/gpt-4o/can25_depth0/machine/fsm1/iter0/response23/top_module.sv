module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);
    // Define state encoding
    typedef enum reg {A, B} state_t;
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            A: next_state = (in) ? A : B;
            B: next_state = (in) ? B : A;
            default: next_state = B; // default state
        endcase
    end

    // State update logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= B; // reset state is B
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        out = (state == B);
    end

endmodule
