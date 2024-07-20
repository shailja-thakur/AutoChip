module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    typedef enum reg [2:0] {
        S0, // Reset State (waiting for 1)
        S1, // Saw first 1
        S2, // Saw second 1
        S3, // Saw 0 after two 1's
        S4  // Saw 1101 sequence
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            S0: next_state = data ? S1 : S0;
            S1: next_state = data ? S2 : S0;
            S2: next_state = data ? S2 : S3;
            S3: next_state = data ? S4 : S0;
            S4: next_state = S4;
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
        end
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            start_shifting <= 0;
        end else if (current_state == S4) begin
            start_shifting <= 1;
        end
    end

endmodule
