module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    typedef enum reg [2:0] {
        STATE_IDLE = 3'b000,
        STATE_1 = 3'b001,
        STATE_11 = 3'b010,
        STATE_110 = 3'b011,
        STATE_1101 = 3'b100
    } state_t;

    state_t state, next_state;

    always @(*) begin
        case (state)
            STATE_IDLE: next_state = (data == 1) ? STATE_1 : STATE_IDLE;
            STATE_1: next_state = (data == 1) ? STATE_11 : STATE_IDLE;
            STATE_11: next_state = (data == 0) ? STATE_110 : STATE_1;
            STATE_110: next_state = (data == 1) ? STATE_1101 : STATE_IDLE;
            STATE_1101: next_state = STATE_1101;
            default: next_state = STATE_IDLE;
        endcase
    end

    always @(posedge clk) begin
        if (reset)
            state <= STATE_IDLE;
        else
            state <= next_state;
    end

    always @(posedge clk) begin
        if (reset)
            start_shifting <= 0;
        else if (state == STATE_1101)
            start_shifting <= 1;
    end

endmodule
