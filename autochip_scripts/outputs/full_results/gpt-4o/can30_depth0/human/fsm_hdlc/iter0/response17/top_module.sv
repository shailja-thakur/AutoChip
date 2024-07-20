module top_module (
    input clk,
    input reset,
    input in,
    output disc,
    output flag,
    output err
);
    // State encoding
    typedef enum logic [2:0] {
        S0, S1, S11, S111, S1111, S11111, S111110, S111111, S1111110
    } state_t;
    
    state_t state, next_state;

    // Output logic
    assign disc = (state == S111110 && !in);
    assign flag = (state == S111110 && in);
    assign err  = (state == S111111 || state == S1111110);

    // State transition logic (Moore FSM)
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= S0; // Reset to the state as if the previous input were 0
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (state)
            S0: next_state = in ? S1 : S0;
            S1: next_state = in ? S11 : S0;
            S11: next_state = in ? S111 : S0;
            S111: next_state = in ? S1111 : S0;
            S1111: next_state = in ? S11111 : S0;
            S11111: next_state = in ? S111111 : S111110;
            S111110: next_state = in ? S1 : S0; // Transition after flag or discard
            S111111: next_state = in ? S1111110 : S0; // Continuing in error
            S1111110: next_state = in ? S1111110 : S0; // Stay in error state until reset
            default: next_state = S0; // Default case for safety
        endcase
    end
endmodule
