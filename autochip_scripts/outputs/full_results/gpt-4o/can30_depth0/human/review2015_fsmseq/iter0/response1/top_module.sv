module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    // Define states
    typedef enum reg [2:0] {S0, S1, S2, S3, S4} state_t;
    state_t state, next_state;
    
    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            state <= S0;
            start_shifting <= 0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @* begin
        case (state)
            S0: next_state = data ? S1 : S0;
            S1: next_state = data ? S2 : S0;
            S2: next_state = data ? S2 : S3;
            S3: next_state = data ? S4 : S0;
            S4: next_state = S4; // Remain in this state once the sequence is detected
            default: next_state = S0;
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            start_shifting <= 0;
        end else if (state == S4) begin
            start_shifting <= 1;
        end
    end

endmodule
