module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);
    typedef enum logic {STATE_A, STATE_B} state_t;
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            STATE_B: next_state = in ? STATE_B : STATE_A;
            STATE_A: next_state = in ? STATE_A : STATE_B;
            default: next_state = STATE_B; // Default/missing state handling
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_B;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (state)
            STATE_B: out = 1;
            STATE_A: out = 0;
        endcase
    end

endmodule
