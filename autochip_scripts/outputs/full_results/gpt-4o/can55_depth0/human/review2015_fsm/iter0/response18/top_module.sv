module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // State encoding
    typedef enum reg [2:0] {
        IDLE = 3'b000,          // Waiting for pattern 1101
        COUNT_PATTERN = 3'b001, // Counting pattern 1101
        SHIFT = 3'b010,         // Shifting in 4 more bits
        WAIT_COUNT = 3'b011,    // Waiting for counters to finish
        NOTIFY = 3'b100         // Notify user and wait for ack
    } state_t;

    state_t state, next_state;
    reg [2:0] bit_counter;

    // State transition logic (sequential)
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic (combinational)
    always @(*) begin
        // Default values
        shift_ena = 0;
        counting = 0;
        done = 0;
        next_state = state;

        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    next_state = COUNT_PATTERN;
                    bit_counter = 1;
                end
            end
            COUNT_PATTERN: begin
                if (bit_counter < 4) begin
                    if ((bit_counter == 1 && data == 1'b1) || (bit_counter == 2 && data == 1'b0) || (bit_counter == 3 && data == 1'b1)) begin
                        bit_counter = bit_counter + 1;
                    end else begin
                        next_state = IDLE;
                    end
                end else begin
                    next_state = SHIFT;
                    bit_counter = 0;
                end
            end
            SHIFT: begin
                shift_ena = 1;
                if (bit_counter < 4) begin
                    bit_counter = bit_counter + 1;
                end else begin
                    next_state = WAIT_COUNT;
                    bit_counter = 0;
                end
            end
            WAIT_COUNT: begin
                counting = 1;
                if (done_counting) begin
                    next_state = NOTIFY;
                end
            end
            NOTIFY: begin
                done = 1;
                if (ack) begin
                    next_state = IDLE;
                end
            end
            default: next_state = IDLE;
        endcase
    end

endmodule
