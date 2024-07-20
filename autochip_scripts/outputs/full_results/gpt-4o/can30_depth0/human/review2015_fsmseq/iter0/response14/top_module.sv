module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    typedef enum logic[2:0] {
        S0 = 3'b000, // Initial state
        S1 = 3'b001, // Detected 1
        S2 = 3'b010, // Detected 11
        S3 = 3'b011, // Detected 110
        S4 = 3'b100  // Detected 1101
    } state_t;
    
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            S0: if (data) next_state = S1; else next_state = S0;
            S1: if (data) next_state = S2; else next_state = S0;
            S2: if (data) next_state = S2; else next_state = S3;
            S3: if (data) next_state = S4; else next_state = S0;
            S4: next_state = S4;
            default: next_state = S0;
        endcase
    end

    // State flip-flops with synchronous reset
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
