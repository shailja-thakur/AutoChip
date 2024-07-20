module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    // Define state encoding
    typedef enum reg [2:0] {
        IDLE = 3'd0,
        S1   = 3'd1,
        S11  = 3'd2,
        S110 = 3'd3,
        S1101= 3'd4
    } state_t;

    // Declare state registers
    reg [2:0] state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            IDLE: next_state = data ? S1 : IDLE;
            S1:   next_state = data ? S11 : IDLE;
            S11:  next_state = data ? S11 : S110;
            S110: next_state = data ? S1101 : IDLE;
            S1101: next_state = S1101; // Remain in this state once 1101 is detected
            default: next_state = IDLE;
        endcase
    end

    // State flip-flops with synchronous reset
    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk) begin
        if (reset)
            start_shifting <= 1'b0;
        else if (state == S1101)
            start_shifting <= 1'b1;
    end

endmodule
