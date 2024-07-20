module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // Define state encoding
    typedef enum logic {
        STATE_A = 1'b0,
        STATE_B = 1'b1
    } state_t;

    state_t state, next_state;

    // Combinational block to determine the next state based on the current state and inputs
    always @(*) begin
        case (state)
            STATE_A: if (j) next_state = STATE_B;
                     else next_state = STATE_A;
            STATE_B: if (k) next_state = STATE_A;
                     else next_state = STATE_B;
            default: next_state = STATE_A;
        endcase
    end

    // Synchronous block to update the state based on clk and areset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_A;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        if (state == STATE_B)
            out = 1'b1;
        else
            out = 1'b0;
    end

endmodule
