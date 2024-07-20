module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    // State declaration
    typedef enum logic [2:0] {
        S0,  // Initial state
        S1,  // State after seeing 1
        S2,  // State after seeing 11
        S3,  // State after seeing 110
        S4   // State after seeing 1101 (final state)
    } state_t;

    state_t state, next_state;
    
    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S0;
            start_shifting <= 0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state; // Default to staying in the same state
        case (state)
            S0: if (data) next_state = S1;
            S1: if (data) next_state = S2; else next_state = S0;
            S2: if (~data) next_state = S3; else next_state = S2;
            S3: if (data) next_state = S4; else next_state = S0;
            S4: next_state = S4;    // Stay in S4 forever once the sequence is found
            default: next_state = S0;
        endcase
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            start_shifting <= 0;
        end else if (state == S4) begin
            start_shifting <= 1;
        end
    end

endmodule
