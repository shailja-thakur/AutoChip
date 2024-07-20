module top_module (
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    typedef enum reg [1:0] {
        S0, // No bits collected
        S1, // Collected '1'
        S2, // Collected '11'
        S3  // Collected '110'
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case(current_state)
            S0: next_state = data ? S1 : S0;
            S1: next_state = data ? S2 : S0;
            S2: next_state = data ? S2 : S3;
            S3: next_state = data ? S1 : S0;
            default: next_state = S0;
        endcase
    end

    // State flip-flops with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            current_state <= S0;
            start_shifting <= 0;
        end else begin
            current_state <= next_state;
            if (current_state == S3 && data == 1)
                start_shifting <= 1;
        end
    end

endmodule
