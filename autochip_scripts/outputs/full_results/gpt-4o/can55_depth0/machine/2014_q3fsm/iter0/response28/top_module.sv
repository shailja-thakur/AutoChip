module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State encoding
    typedef enum reg [2:0] {
        STATE_A,
        STATE_B,
        STATE_C,
        STATE_S10,
        STATE_S11,
        STATE_S20,
        STATE_S21,
        STATE_S22
    } state_t;

    state_t state, next_state;

    // Combinational logic for next state
    always @(*) begin
        case (state)
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

    // Sequential logic for state transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= STATE_A;
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset) 
            z <= 0;
        else 
            z <= (state == STATE_S21 || state == STATE_S22);
    end
endmodule
