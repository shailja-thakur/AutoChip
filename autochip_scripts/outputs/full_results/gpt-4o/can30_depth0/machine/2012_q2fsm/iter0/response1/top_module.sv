module top_module (
    input clk,
    input reset,
    input w,
    output z
);

    // State encoding
    typedef enum logic [2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100,
        STATE_F = 3'b101
    } state_t;

    state_t state, next_state;

    // State transition on clock edge
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= STATE_A;
        else
            state <= next_state;
    end

    // Determining next state based on current state and input w
    always @(*) begin
        case (state)
            STATE_A: next_state = w ? STATE_B : STATE_A;
            STATE_B: next_state = w ? STATE_C : STATE_D;
            STATE_C: next_state = w ? STATE_E : STATE_D;
            STATE_D: next_state = w ? STATE_F : STATE_A;
            STATE_E: next_state = w ? STATE_E : STATE_D;
            STATE_F: next_state = w ? STATE_C : STATE_D;
            default: next_state = STATE_A;
        endcase
    end

    // Output logic
    assign z = (state == STATE_E) || (state == STATE_F);

endmodule
