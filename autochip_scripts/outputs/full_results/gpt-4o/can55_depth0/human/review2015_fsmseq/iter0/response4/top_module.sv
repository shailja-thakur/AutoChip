module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    typedef enum reg [2:0] {
        S0, // No bits or one '0'
        S1, // One '1'
        S2, // '11'
        S3, // '110'
        S4  // '1101' found
    } state_t;
    
    state_t current_state, next_state;
    
    always @(posedge clk) begin
        if (reset) begin
            current_state <= S0;
            start_shifting <= 0;
        end else begin
            current_state <= next_state;
            if (current_state == S4)
                start_shifting <= 1;
        end
    end
    
    // Next state logic
    always @(*) begin
        case (current_state)
            S0: next_state = data ? S1 : S0;
            S1: next_state = data ? S2 : S0;
            S2: next_state = data ? S2 : S3;
            S3: next_state = data ? S4 : S0;
            S4: next_state = S4; // Remain in S4 once '1101' is detected
            default: next_state = S0;
        endcase
    end

endmodule
