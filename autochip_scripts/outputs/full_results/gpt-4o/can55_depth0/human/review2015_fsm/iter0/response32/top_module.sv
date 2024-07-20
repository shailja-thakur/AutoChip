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

    // Define state encoding
    typedef enum reg [2:0] {
        IDLE,
        DETECT1,
        DETECT11,
        DETECT110,
        DETECT1101,
        SHIFT,
        COUNT,
        DONE
    } state_t;

    state_t state, next_state;

    // State register logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic and outputs
    always @(*) begin
        // Default values
        shift_ena = 0;
        counting = 0;
        done = 0;

        case (state)
            IDLE: begin
                if (data == 1)
                    next_state = DETECT1;
                else
                    next_state = IDLE;
            end

            DETECT1: begin
                if (data == 1)
                    next_state = DETECT11;
                else
                    next_state = IDLE;
            end

            DETECT11: begin
                if (data == 0)
                    next_state = DETECT110;
                else
                    next_state = IDLE;
            end

            DETECT110: begin
                if (data == 1)
                    next_state = DETECT1101;
                else
                    next_state = IDLE;
            end

            DETECT1101: begin
                next_state = SHIFT;
            end

            SHIFT: begin
                shift_ena = 1;
                if (/* shift count reaches 4 cycles */) // Assuming the timing is maintained elsewhere
                    next_state = COUNT;
                else
                    next_state = SHIFT;
            end

            COUNT: begin
                counting = 1;
                if (done_counting)
                    next_state = DONE;
                else
                    next_state = COUNT;
            end

            DONE: begin
                done = 1;
                if (ack)
                    next_state = IDLE;
                else
                    next_state = DONE;
            end

            default: next_state = IDLE;
        endcase
    end

endmodule
