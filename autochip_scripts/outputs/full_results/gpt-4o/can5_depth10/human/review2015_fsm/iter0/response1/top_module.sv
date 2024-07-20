module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack
);

    // State encoding
    typedef enum reg [2:0] {
        IDLE = 3'b000,
        DETECT1 = 3'b001,
        DETECT11 = 3'b010,
        DETECT110 = 3'b011,
        DETECT1101 = 3'b100,
        SHIFT = 3'b101,
        WAIT_COUNT = 3'b110,
        DONE = 3'b111
    } state_t;

    state_t state, next_state;

    // State machine
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        next_state = state; // Default state transition is to stay in the same state
        shift_ena = 0;
        counting = 0;
        done = 0;

        case (state)
            IDLE: begin
                if (data)
                    next_state = DETECT1;
            end
            DETECT1: begin
                if (data)
                    next_state = DETECT11;
                else
                    next_state = IDLE;
            end
            DETECT11: begin
                if (~data)
                    next_state = DETECT110;
                else
                    next_state = IDLE;
            end
            DETECT110: begin
                if (data)
                    next_state = DETECT1101;
                else
                    next_state = IDLE;
            end
            DETECT1101: begin
                shift_ena = 1;
                next_state = SHIFT;
            end
            SHIFT: begin
                shift_ena = 1;
                next_state = SHIFT;
                if (done_counting)  // We need a signal to indicate we are done shifting; assuming done_counting is reused here
                    next_state = WAIT_COUNT;
            end
            WAIT_COUNT: begin
                counting = 1;
                next_state = WAIT_COUNT;
                if (done_counting)
                    next_state = DONE;
            end
            DONE: begin
                done = 1;
                next_state = DONE;
                if (ack)
                    next_state = IDLE;
            end
        endcase
    end

endmodule
