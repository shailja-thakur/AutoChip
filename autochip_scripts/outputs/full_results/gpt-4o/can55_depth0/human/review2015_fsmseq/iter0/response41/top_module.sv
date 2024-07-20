module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    // Define states
    typedef enum reg [2:0] {
        S0, // Initial state
        S1, // Detected first 1
        S2, // Detected 11
        S3, // Detected 110
        S4  // Detected 1101
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(posedge clk) begin
        if (reset)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            S0: next_state = data ? S1 : S0;
            S1: next_state = data ? S2 : S0;
            S2: next_state = data ? S2 : S3;
            S3: next_state = data ? S4 : S0;
            S4: next_state = S4; // Once sequence is detected, stay in S4
            default: next_state = S0;
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        if (reset)
            start_shifting <= 0;
        else if (current_state == S4)
            start_shifting <= 1;
    end

endmodule
