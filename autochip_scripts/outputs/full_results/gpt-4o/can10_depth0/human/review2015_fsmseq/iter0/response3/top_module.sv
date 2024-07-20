module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    // State encoding
    typedef enum reg [2:0] {
        STATE_IDLE = 3'b000,
        STATE_S1   = 3'b001,
        STATE_S11  = 3'b010,
        STATE_S110 = 3'b011,
        STATE_FOUND = 3'b100
    } state_t;

    state_t state, next_state;

    // Next state logic
    always @(*) begin
        case (state)
            STATE_IDLE: begin
                if (data == 1)
                    next_state = STATE_S1;
                else
                    next_state = STATE_IDLE;
            end

            STATE_S1: begin
                if (data == 1)
                    next_state = STATE_S11;
                else
                    next_state = STATE_IDLE;
            end

            STATE_S11: begin
                if (data == 0)
                    next_state = STATE_S110;
                else
                    next_state = STATE_S1;
            end

            STATE_S110: begin
                if (data == 1)
                    next_state = STATE_FOUND;
                else
                    next_state = STATE_IDLE;
            end

            STATE_FOUND: begin
                next_state = STATE_FOUND;
            end

            default: begin
                next_state = STATE_IDLE;
            end
        endcase
    end

    // State flip-flops with synchronous reset
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
        else if (state == STATE_FOUND)
            start_shifting <= 1;
    end

endmodule
