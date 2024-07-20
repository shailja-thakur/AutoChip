module top_module (
    input clk,
    input reset,
    input w,
    output z
);

    // State Declaration
    typedef enum logic [2:0] {STATE_A, STATE_B, STATE_C, STATE_D, STATE_E, STATE_F} state_t;
    
    state_t current_state, next_state;

    // State Transition Logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) 
            current_state <= STATE_A;
        else 
            current_state <= next_state;
    end

    // Next State Logic
    always_comb begin
        case (current_state)
            STATE_A: next_state = (w) ? STATE_A : STATE_B;
            STATE_B: next_state = (w) ? STATE_D : STATE_C;
            STATE_C: next_state = (w) ? STATE_D : STATE_E;
            STATE_D: next_state = (w) ? STATE_A : STATE_F;
            STATE_E: next_state = (w) ? STATE_D : STATE_E;
            STATE_F: next_state = (w) ? STATE_D : STATE_C;
            default: next_state = STATE_A;
        endcase
    end

    // Output Logic
    assign z = (current_state == STATE_E) || (current_state == STATE_F);

endmodule
