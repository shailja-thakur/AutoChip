module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    // Declare state encoding
    typedef enum logic [2:0] {
        S0 = 3'b000, // Initial state
        S1 = 3'b001, // 1 detected
        S2 = 3'b010, // 11 detected
        S3 = 3'b011, // 110 detected
        S4 = 3'b100  // 1101 detected
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            S0: next_state = (data) ? S1 : S0;
            S1: next_state = (data) ? S2 : S0;
            S2: next_state = (data) ? S2 : S3;
            S3: next_state = (data) ? S4 : S0;
            S4: next_state = S4; // Stay in S4 once 1101 detected
            default: next_state = S0;
        endcase
    end

    // Sequential logic for state transition
    always @(posedge clk) begin
        if (reset) begin
            state <= S0;
            start_shifting <= 1'b0;
        end else begin
            state <= next_state;
            if (state == S4)
                start_shifting <= 1'b1;
        end
    end

endmodule
