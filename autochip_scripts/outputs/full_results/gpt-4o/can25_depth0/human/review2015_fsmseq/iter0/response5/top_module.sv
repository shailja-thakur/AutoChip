module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    // State encoding
    typedef enum reg [2:0] {
        IDLE       = 3'b000,
        STATE_1    = 3'b001,
        STATE_11   = 3'b010,
        STATE_110  = 3'b011,
        STATE_1101 = 3'b100
    } state_t;

    state_t state, next_state;
    
    // State transition logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (data)
                    next_state = STATE_1;
                else
                    next_state = IDLE;
            end
            STATE_1: begin
                if (data)
                    next_state = STATE_11;
                else
                    next_state = IDLE;
            end
            STATE_11: begin
                if (data)
                    next_state = STATE_11;
                else
                    next_state = STATE_110;
            end
            STATE_110: begin
                if (data)
                    next_state = STATE_1101;
                else
                    next_state = IDLE;
            end
            STATE_1101: begin
                next_state = STATE_1101; // Stay in this state once the sequence is detected
            end
            default: next_state = IDLE;
        endcase
    end

    // State flip-flops with synchronous reset
    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
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
