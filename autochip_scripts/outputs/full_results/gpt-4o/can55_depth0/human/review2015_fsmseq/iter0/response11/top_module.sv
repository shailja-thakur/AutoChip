module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    typedef enum logic [2:0] {
        S0, // Initial state
        S1, // First 1 received
        S2, // 11 received
        S3, // 110 received
        S4  // 1101 received
    } state_t;

    state_t state, next_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            state <= S0;
            start_shifting <= 0;
        end else begin
            state <= next_state;
            if (state == S4)
                start_shifting <= 1;
        end
    end

    always_comb begin
        case (state)
            S0: next_state = data ? S1 : S0;
            S1: next_state = data ? S2 : S0;
            S2: next_state = data ? S2 : S3;
            S3: next_state = data ? S4 : S0;
            S4: next_state = data ? S4 : S4; // Remain in S4 once sequence is found
            default: next_state = S0;
        endcase
    end
endmodule
