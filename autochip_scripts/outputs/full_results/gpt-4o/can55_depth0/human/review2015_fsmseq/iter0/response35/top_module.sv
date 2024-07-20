module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    // State encoding
    typedef enum reg [2:0] {
        S0, // initial state
        S1, // first 1
        S2, // second 1
        S3, // 0 after 11
        S4  // 1 after 110
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(posedge clk) begin
        if(reset)
            state <= S0;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case(state)
            S0: next_state = data ? S1 : S0;
            S1: next_state = data ? S2 : S0;
            S2: next_state = data ? S2 : S3;
            S3: next_state = data ? S4 : S0;
            S4: next_state = data ? S2 : S0;
            default: next_state = S0;
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        if(reset)
            start_shifting <= 1'b0;
        else if(state == S4 && data == 1'b1)
            start_shifting <= 1'b1;
    end
endmodule
