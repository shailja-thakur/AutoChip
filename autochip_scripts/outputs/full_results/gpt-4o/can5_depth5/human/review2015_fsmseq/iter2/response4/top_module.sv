module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    // State encoding
    typedef enum reg [2:0] {
        S_IDLE = 3'd0,
        S_1 = 3'd1,
        S_11 = 3'd2,
        S_110 = 3'd3,
        S_1101 = 3'd4
    } state_t;

    state_t state, next_state;

    // Next state logic
    always @(*) begin
        case (state)
            S_IDLE: next_state = data ? S_1 : S_IDLE;
            S_1: next_state = data ? S_11 : S_IDLE;
            S_11: next_state = data ? S_11 : S_110;
            S_110: next_state = data ? S_1101 : S_IDLE;
            S_1101: next_state = S_1101; // Stay in final state once sequence is detected
            default: next_state = S_IDLE;
        endcase
    end

    // State flip-flops with synchronous reset
    always @(posedge clk) begin
        if (reset)
            state <= S_IDLE;
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk) begin
        if (reset)
            start_shifting <= 1'b0;
        else if (state == S_1101)
            start_shifting <= 1'b1;
    end

endmodule
