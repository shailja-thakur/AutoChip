module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // State encoding
    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01
    } state_t;

    state_t state, next_state;

    // State transition on clock edge
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= STATE_B;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (state)
            STATE_A: if (in == 1'b0) next_state = STATE_B;
                     else next_state = STATE_A;
            STATE_B: if (in == 1'b0) next_state = STATE_A;
                     else next_state = STATE_B;
            default: next_state = STATE_B;
        endcase
    end

    // Output logic
    always_comb begin
        case (state)
            STATE_A: out = 1'b0;
            STATE_B: out = 1'b1;
            default: out = 1'b1;
        endcase
    end

endmodule
