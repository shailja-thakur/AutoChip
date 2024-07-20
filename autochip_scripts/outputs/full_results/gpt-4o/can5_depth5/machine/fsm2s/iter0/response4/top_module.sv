module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // Define state encoding
    typedef enum reg {A, B} state_t;
    state_t state, next_state;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A; // Initialize to state A on reset
        else
            state <= next_state; // Transition to next state
    end

    // Next-state logic
    always @(*) begin
        case (state)
            A: begin
                if (j)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                if (k)
                    next_state = A;
                else
                    next_state = B;
            end
        endcase
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            out <= 0; // Output is low when in state A
        else
            out <= (state == B); // Output is high when in state B
    end

endmodule
