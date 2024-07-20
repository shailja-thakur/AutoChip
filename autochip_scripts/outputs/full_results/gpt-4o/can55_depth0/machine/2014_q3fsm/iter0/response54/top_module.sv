module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);
    // Define state encoding
    typedef enum reg [2:0] {
        STATE_A = 3'd0,
        STATE_B = 3'd1,
        STATE_C = 3'd2,
        STATE_S10 = 3'd3,
        STATE_S11 = 3'd4,
        STATE_S20 = 3'd5,
        STATE_S21 = 3'd6,
        STATE_S22 = 3'd7
    } state_t;

    // Define state and next state registers
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            STATE_A:   next_state = s ? STATE_B : STATE_A;
            STATE_B:   next_state = w ? STATE_S11 : STATE_S10;
            STATE_C:   next_state = w ? STATE_S11 : STATE_S10;
            STATE_S10: next_state = w ? STATE_S21 : STATE_S20;
            STATE_S11: next_state = w ? STATE_S22 : STATE_S21;
            STATE_S20: next_state = STATE_B;
            STATE_S21: next_state = w ? STATE_C : STATE_B;
            STATE_S22: next_state = w ? STATE_B : STATE_C;
            default:   next_state = STATE_A;
        endcase
    end

    // State register logic (sequential part)
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= STATE_A;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        // Output logic can be defined here, not specified in the initial description
        z = 0;
    end

endmodule
