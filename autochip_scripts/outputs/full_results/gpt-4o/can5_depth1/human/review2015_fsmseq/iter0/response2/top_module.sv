module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    // States in the state machine
    typedef enum reg [2:0] {
        S0, // Initial state
        S1, // State after seeing '1'
        S2, // State after seeing '11'
        S3, // State after seeing '110'
        S4  // State when 1101 is detected
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            S0: next_state = data ? S1 : S0;
            S1: next_state = data ? S2 : S0;
            S2: next_state = data ? S2 : S3;
            S3: next_state = data ? S4 : S0;
            S4: next_state = S4; // Stay in S4 once 1101 is detected
            default: next_state = S0;
        endcase
    end

    // State flip-flops with synchronous reset
    always @(posedge clk) begin
        if (reset)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            start_shifting <= 1'b0;
        else if (current_state == S4)
            start_shifting <= 1'b1;
    end

endmodule
