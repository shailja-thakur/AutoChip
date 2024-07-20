module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State Encoding
    typedef enum logic [2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_S10 = 3'b011,
        STATE_S11 = 3'b100,
        STATE_S20 = 3'b101,
        STATE_S21 = 3'b110,
        STATE_S22 = 3'b111
    } state_t;

    state_t state, next_state;

    // State Transition Logic
    always @(*) begin
        case(state)
            STATE_A: next_state = s ? STATE_B : STATE_A;
            STATE_B: next_state = w ? STATE_S11 : STATE_S10;
            STATE_C: next_state = w ? STATE_S11 : STATE_S10;
            STATE_S10: next_state = w ? STATE_S21 : STATE_S20;
            STATE_S11: next_state = w ? STATE_S22 : STATE_S21;
            STATE_S20: next_state = STATE_B;
            STATE_S21: next_state = w ? STATE_C : STATE_B;
            STATE_S22: next_state = w ? STATE_B : STATE_C;
            default: next_state = STATE_A;
        endcase
    end

    // State Update Logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= STATE_A;
        else
            state <= next_state;
    end

    // Output Logic
    always @(*) begin
        // Assuming z should be asserted in states B, S21, and S11
        z = (state == STATE_B) || (state == STATE_S21) || (state == STATE_S11);
    end

endmodule
