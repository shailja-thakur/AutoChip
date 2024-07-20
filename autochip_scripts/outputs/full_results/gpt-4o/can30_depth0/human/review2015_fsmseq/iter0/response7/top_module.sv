module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    // State encoding
    typedef enum reg [2:0] {
        S0 = 3'b000,
        S1 = 3'b001,
        S2 = 3'b010,
        S3 = 3'b011,
        S4 = 3'b100
    } state_t;

    state_t state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            S0: next_state = data ? S1 : S0; // 1
            S1: next_state = data ? S2 : S0; // 11
            S2: next_state = data ? S2 : S3; // 110
            S3: next_state = data ? S4 : S0; // 1101
            S4: next_state = S4;             // Stay in S4 once sequence is found
            default: next_state = S0;
        endcase
    end

    // State flip-flops (sequential)
    always @(posedge clk) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk) begin
        if (reset)
            start_shifting <= 0;
        else if (state == S4)
            start_shifting <= 1;
    end
endmodule
