module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    typedef enum logic [2:0] {
        S0 = 3'b000, // Initial state
        S1 = 3'b001, // Detected first '1'
        S2 = 3'b010, // Detected '11'
        S3 = 3'b011, // Detected '110'
        S4 = 3'b100  // Detected '1101'
    } state_t;

    state_t state, next_state;

    // State transition logic (next state)
    always @(*) begin
        case(state)
            S0: next_state = data ? S1 : S0;
            S1: next_state = data ? S2 : S0;
            S2: next_state = data ? S2 : S3;
            S3: next_state = data ? S4 : S0;
            S4: next_state = S4; // Stay in state S4 once sequence is detected
            default: next_state = S0;
        endcase
    end

    // State register (sequential logic)
    always @(posedge clk) begin
        if (reset) begin
            state <= S0;
            start_shifting <= 0;
        end
        else begin
            state <= next_state;
            if (state == S4)
                start_shifting <= 1;
        end
    end

endmodule
