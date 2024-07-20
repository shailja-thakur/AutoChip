module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // State encoding
    typedef enum reg {STATE_A, STATE_B} state_t;
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            STATE_A: if (in == 1'b0) next_state = STATE_B;
                     else next_state = STATE_A;
            STATE_B: if (in == 1'b0) next_state = STATE_A;
                     else next_state = STATE_B;
            default: next_state = STATE_B; // Should never happen, default to STATE_B
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
    always @(state) begin
        case (state)
            STATE_A: out = 1'b0;
            STATE_B: out = 1'b1;
            default: out = 1'b1; // Should never happen, default to 1
        endcase
    end

endmodule
