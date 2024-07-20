module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    // State declaration
    typedef enum logic [2:0] {
        S0, // Initial state
        S1, // State after 1
        S2, // State after 11
        S3, // State after 110
        S4  // State after 1101
    } state_t;

    state_t state, next_state;

    // State register
    always_ff @(posedge clk) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        case(state)
            S0: next_state = data ? S1 : S0;          // Await first 1
            S1: next_state = data ? S2 : S0;          // Seen 1, awaiting another 1
            S2: next_state = data ? S2 : S3;          // Seen 11, awaiting 0
            S3: next_state = data ? S4 : S0;          // Seen 110, awaiting 1
            S4: next_state = S4;                      // Sequence 1101 detected, stay here
            default: next_state = S0;
        endcase
    end

    // Output logic
    always_ff @(posedge clk) begin
        if (reset) 
            start_shifting <= 0;
        else if (state == S4)
            start_shifting <= 1;
    end 

endmodule
