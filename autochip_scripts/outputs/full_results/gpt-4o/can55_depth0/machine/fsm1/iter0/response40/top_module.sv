module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    // Define state encoding
    typedef enum reg [1:0] {STATE_A = 1'b0, STATE_B = 1'b1} state_type;
    
    // State registers
    state_type state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            STATE_A: if (in) next_state = STATE_A;
                     else    next_state = STATE_B;
            STATE_B: if (in) next_state = STATE_B;
                     else    next_state = STATE_A;
            default: next_state = STATE_B; // Default to state B
        endcase
    end

    // State flip-flops (sequential)
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_B;
        else
            state <= next_state;
    end

    // Output logic
    assign out = (state == STATE_B);

endmodule
