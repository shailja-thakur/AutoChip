module top_module (
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    // State encoding
    typedef enum logic [2:0] {
        STATE_IDLE      = 3'b000,
        STATE_S1        = 3'b001,
        STATE_S11       = 3'b010,
        STATE_S110      = 3'b011,
        STATE_S1101     = 3'b100
    } state_t;

    state_t state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset)
            state <= STATE_IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        next_state = state;
        case (state)
            STATE_IDLE: next_state = data ? STATE_S1 : STATE_IDLE;
            STATE_S1: next_state = data ? STATE_S11 : STATE_IDLE;
            STATE_S11: next_state = data ? STATE_S11 : STATE_S110;
            STATE_S110: next_state = data ? STATE_S1101 : STATE_IDLE;
            STATE_S1101: next_state = STATE_S1101;
            default: next_state = STATE_IDLE;
        endcase
    end

    // Output logic
    always_ff @(posedge clk) begin
        if (reset)
            start_shifting <= 0;
        else if (state == STATE_S1101)
            start_shifting <= 1;
    end

endmodule
