module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    // Define states
    typedef enum logic {STATE_A, STATE_B} state_t;
    state_t state, next_state;

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_B; // Reset state to B
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (state)
            STATE_A: next_state = in ? STATE_A : STATE_B;
            STATE_B: next_state = in ? STATE_B : STATE_A;
            default: next_state = STATE_B; // Default state
        endcase
    end

    // Output logic
    assign out = (state == STATE_B);

endmodule
