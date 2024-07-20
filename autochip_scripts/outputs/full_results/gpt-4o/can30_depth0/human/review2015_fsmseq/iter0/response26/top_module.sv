module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    // State declaration
    typedef enum reg [2:0] {
        IDLE,
        S1,
        S11,
        S110,
        S1101
    } state_t;

    state_t state, next_state;
    
    // Sequential logic for state transition
    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end
    
    // Combinational logic for next state
    always @(*) begin
        case (state)
            IDLE: next_state = data ? S1 : IDLE;
            S1: next_state = data ? S11 : IDLE;
            S11: next_state = data ? S11 : S110;
            S110: next_state = data ? S1101 : IDLE;
            S1101: next_state = S1101;
            default: next_state = IDLE;
        endcase
    end
    
    // Output logic
    always @(posedge clk) begin
        if (reset)
            start_shifting <= 0;
        else if (state == S1101)
            start_shifting <= 1;
    end

endmodule
