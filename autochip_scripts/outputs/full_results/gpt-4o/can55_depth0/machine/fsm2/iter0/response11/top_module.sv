module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

    // State declaration
    typedef enum logic [1:0] {STATE_A, STATE_B} state_t;
    state_t current_state, next_state;

    // Combinational block to determine the next state
    always_comb begin
        case (current_state)
            STATE_A: next_state = (j) ? STATE_B : STATE_A;
            STATE_B: next_state = (k) ? STATE_A : STATE_B;
            default: next_state = STATE_A;
        endcase
    end

    // Sequential block to update the current state
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= STATE_A;
        else
            current_state <= next_state;
    end

    // Output logic
    assign out = (current_state == STATE_B);

endmodule
