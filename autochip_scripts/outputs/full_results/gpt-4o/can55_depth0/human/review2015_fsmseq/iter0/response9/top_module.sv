module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    // State encoding
    typedef enum reg [2:0] {
        S0, // Initial state
        S1, // First 1 detected
        S2, // Second 1 detected
        S3, // 0 after two 1s detected
        S4  // 1 after previous sequence 110 detected
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(posedge clk) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            S0: next_state = data ? S1 : S0;
            S1: next_state = data ? S2 : S0;
            S2: next_state = data ? S2 : S3;
            S3: next_state = data ? S4 : S0;
            S4: next_state = S4;
            default: next_state = S0;
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        if (reset)
            start_shifting <= 0;
        else if (state == S4)
            start_shifting <= 1;
    end

endmodule
