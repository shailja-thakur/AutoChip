module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    typedef enum reg [2:0] {STATE_IDLE, STATE_1, STATE_11, STATE_110, STATE_1101} state_t;
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            STATE_IDLE: next_state = (data) ? STATE_1 : STATE_IDLE;
            STATE_1:    next_state = (data) ? STATE_11 : STATE_IDLE;
            STATE_11:   next_state = (data) ? STATE_11 : STATE_110;
            STATE_110:  next_state = (data) ? STATE_1101 : STATE_IDLE;
            STATE_1101: next_state = STATE_1101;
            default:    next_state = STATE_IDLE;
        endcase
    end

    // State update on clock edge
    always @(posedge clk) begin
        if (reset)
            state <= STATE_IDLE;
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk) begin
        if (reset)
            start_shifting <= 0;
        else if (state == STATE_1101)
            start_shifting <= 1;
    end
endmodule
