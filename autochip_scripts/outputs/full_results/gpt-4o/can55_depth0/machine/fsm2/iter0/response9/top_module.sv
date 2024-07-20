module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // State encoding
    typedef enum logic {STATE_A, STATE_B} state_t;
    state_t state, next_state;

    // Combinational logic to determine the next state
    always @(*) begin
        case (state)
            STATE_A: begin
                if (j)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            STATE_B: begin
                if (k)
                    next_state = STATE_A;
                else
                    next_state = STATE_B;
            end
            default: next_state = STATE_A; // Default to STATE_A
        endcase
    end

    // Sequential logic to update the state
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_A; // Reset to STATE_A
        else
            state <= next_state; // Update to the next state
    end

    // Output logic
    always @(*) begin
        case (state)
            STATE_A: out = 1'b0; // Current state is A, out is low
            STATE_B: out = 1'b1; // Current state is B, out is high
            default: out = 1'b0; // Default to low
        endcase
    end

endmodule
