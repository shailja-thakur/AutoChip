module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    typedef enum reg {STATE_A, STATE_B} state_t;
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            STATE_A: if (in) next_state = STATE_A; else next_state = STATE_B;
            STATE_B: if (in) next_state = STATE_B; else next_state = STATE_A;
            default: next_state = STATE_B;  // Default state (B) if out of defined states
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
    always @(posedge clk or posedge areset) begin
        if (areset)
            out <= 1'b1;  // Default output (1) at reset
        else
            case (state)
                STATE_A: out <= 1'b0;
                STATE_B: out <= 1'b1;
                default: out <= 1'b1;
            endcase
    end

endmodule
