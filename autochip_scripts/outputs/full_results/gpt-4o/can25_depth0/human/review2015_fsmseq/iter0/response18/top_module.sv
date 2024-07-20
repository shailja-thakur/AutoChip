module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    // State encoding
    typedef enum logic [2:0] {
        S0,  // initial state
        S1,  // got 1
        S2,  // got 11
        S3,  // got 110
        S4   // got 1101 
    } state_t;
    
    state_t state, next_state;

    // State transition
    always_ff @(posedge clk) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        next_state = state;
        case (state)
            S0: next_state = data ? S1 : S0;
            S1: next_state = data ? S2 : S0;
            S2: next_state = data ? S2 : S3;
            S3: next_state = data ? S4 : S0;
            S4: next_state = S4;
            default: next_state = S0;
        endcase
    end

    // Output logic
    always_ff @(posedge clk) begin
        if (reset)
            start_shifting <= 0;
        else if (state == S4)
            start_shifting <= 1;
    end

endmodule
