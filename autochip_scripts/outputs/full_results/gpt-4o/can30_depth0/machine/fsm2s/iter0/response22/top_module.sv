module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // Define the states
    typedef enum logic {A, B} state_t;
    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk or posedge reset)
    begin
        if (reset)
            current_state <= A;
        else
            current_state <= next_state;
    end

    // Next state logic
    always_comb
    begin
        case (current_state)
            A: next_state = (j) ? B : A;
            B: next_state = (k) ? A : B;
            default: next_state = A; // Default to state A in case of invalid state
        endcase
    end

    // Output logic
    always_ff @(posedge clk or posedge reset)
    begin
        if (reset)
            out <= 1'b0;
        else
            out <= (current_state == B);
    end
endmodule
