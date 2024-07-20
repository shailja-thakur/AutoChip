module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

    // State encoding
    typedef enum logic [1:0] {STATE_A = 2'b00, STATE_B = 2'b01} state_t;
    state_t current_state, next_state;

    // Combinational always block to determine the next state
    always_comb begin
        case (current_state)
            STATE_A: next_state = j ? STATE_B : STATE_A;
            STATE_B: next_state = k ? STATE_A : STATE_B;
            default: next_state = STATE_A; // default state
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
    assign out = (current_state == STATE_B);

endmodule
