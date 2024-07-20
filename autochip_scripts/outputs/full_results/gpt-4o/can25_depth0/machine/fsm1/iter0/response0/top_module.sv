module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);
    // State encoding
    typedef enum reg {STATE_A, STATE_B} state_t;
    state_t state, next_state;

    // State transition
    always @(*) begin
        case (state)
            STATE_A: if (in) next_state = STATE_A;
                     else next_state = STATE_B;
            STATE_B: if (in) next_state = STATE_B;
                     else next_state = STATE_A;
            default: next_state = STATE_B;  // Default to STATE_B (should never be used)
        endcase
    end

    // State update
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
            default: out = 1'b0;  // Default to 0 (should never be used)
        endcase
    end
endmodule
