module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // State encoding
    typedef enum logic [0:0] {
        STATE_A = 1'b0,
        STATE_B = 1'b1
    } state_t;

    // State registers
    state_t current_state, next_state;

    // Combinational always block to determine the next state
    always_comb begin
        case (current_state)
            STATE_A: next_state = j ? STATE_B : STATE_A;
            STATE_B: next_state = k ? STATE_A : STATE_B;
            default: next_state = STATE_A; // default case to avoid latches
        endcase
    end

    // Clocked always block to update the state
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= STATE_A;
        else
            current_state <= next_state;
    end

    // Output logic
    always_comb begin
        out = (current_state == STATE_B);
    end

endmodule
