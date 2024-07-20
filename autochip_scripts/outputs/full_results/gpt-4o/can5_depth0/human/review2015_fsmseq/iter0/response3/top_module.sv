module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    typedef enum reg [2:0] {
        S0,  // initial state
        S1,  // got 1
        S2,  // got 11
        S3,  // got 110
        S4   // got 1101
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            state <= S0;
            start_shifting <= 0;
        end else begin
            state <= next_state;
            if (next_state == S4)
                start_shifting <= 1;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            S0: next_state = data ? S1 : S0;
            S1: next_state = data ? S2 : S0;
            S2: next_state = data ? S2 : S3;
            S3: next_state = data ? S4 : S0;
            S4: next_state = S4;  // stay in S4 once 1101 is found
            default: next_state = S0;
        endcase
    end
endmodule
