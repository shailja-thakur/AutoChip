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
        IDLE        = 3'b000,
        DETECT_1    = 3'b001,
        DETECT_11   = 3'b010,
        DETECT_110  = 3'b011,
        DETECT_1101 = 3'b100,
        SHIFT       = 3'b101,
        COUNT       = 3'b110,
        DONE        = 3'b111
    } state_t;

    state_t state, next_state;
    reg [1:0] bit_counter;  // bit counter needs to be 2 bits to count 0 to 3 (4 cycles)

    // State transitions
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next-state logic and output logic
    always @(*) begin
        // Defaults
        shift_ena = 0;
        counting = 0;
        done = 0;
        next_state = state;

        case(state)
            IDLE: begin
                if (data)
                    next_state = DETECT_1;
                else
                    next_state = IDLE;
            end

            DETECT_1: begin
                if (data)
                    next_state = DETECT_11;
                else
                    next_state = IDLE;
            end

            DETECT_11: begin
                if (!data)
                    next_state = DETECT_110;
                else
                    next_state = IDLE;
            end

            DETECT_110: begin
                if (data)
                    next_state = DETECT_1101;
                else
                    next_state = IDLE;
            end

            DETECT_1101: begin
                next_state = SHIFT;
            end

            SHIFT: begin
                shift_ena = 1;
                if (bit_counter == 2'b11)
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

    // Bit counter logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            bit_counter <= 0;
        else if (state == SHIFT)
            bit_counter <= bit_counter + 1;
        else
            bit_counter <= 0;
    end

endmodule
