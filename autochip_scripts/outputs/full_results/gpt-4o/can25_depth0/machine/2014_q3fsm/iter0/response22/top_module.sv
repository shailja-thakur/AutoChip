module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    typedef enum logic [3:0] {
        STATE_A = 4'd0,
        STATE_B = 4'd1,
        STATE_C = 4'd2,
        STATE_S10 = 4'd3,
        STATE_S11 = 4'd4,
        STATE_S20 = 4'd5,
        STATE_S21 = 4'd6,
        STATE_S22 = 4'd7
    } state_t;

    state_t state, next_state;

    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= STATE_A;
        else
            state <= next_state;
    end

    always_comb begin
        next_state = state;
        z = 1'b0;
        case (state)
            STATE_A: if (s) next_state = STATE_B;
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

endmodule
