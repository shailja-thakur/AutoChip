module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    // State encoding
    typedef enum logic [2:0] {
        S0 = 3'b000,
        S1 = 3'b001,
        S2 = 3'b010,
        S3 = 3'b011,
        S4 = 3'b100
    } state_t;
    
    state_t current_state, next_state;

    // Sequential logic for state transition
    always_ff @(posedge clk) begin
        if (reset)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // Combinational logic for next state determination
    always_comb begin
        case (current_state)
            S0: next_state = data ? S1 : S0;
            S1: next_state = data ? S2 : S0;
            S2: next_state = data ? S2 : S3;
            S3: next_state = data ? S4 : S0;
            S4: next_state = S4;  // Stay in S4 once the sequence is detected
        endcase
    end

    // Output logic
    always_ff @(posedge clk) begin
        if (reset)
            start_shifting <= 0;
        else if (current_state == S4)
            start_shifting <= 1;
    end

endmodule
