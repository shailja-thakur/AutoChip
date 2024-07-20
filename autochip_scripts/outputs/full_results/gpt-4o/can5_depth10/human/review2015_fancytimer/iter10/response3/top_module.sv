module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    // State encoding
    typedef enum reg [2:0] {
        IDLE = 3'b000,
        PATTERN_DETECTED = 3'b001,
        LOAD_DELAY = 3'b010,
        COUNTDOWN = 3'b011,
        DONE = 3'b100
    } state_t;

    state_t state, next_state;
    reg [3:0] pattern, next_pattern;
    reg [3:0] delay, next_delay;
    reg [15:0] counter, next_counter;
    reg [3:0] next_count;
    reg [2:0] bits_received, next_bits_received;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            pattern <= 4'b0;
            delay <= 4'b0;
            counter <= 16'b0;
            count <= 4'b1111; // set to all 1's instead of 0 for don't-care
            counting <= 1'b0;
            done <= 1'b0;
            bits_received <= 3'b0;
        end else begin
            state <= next_state;
            pattern <= next_pattern;
            delay <= next_delay;
            counter <= next_counter;
            count <= next_count;
            bits_received <= next_bits_received;
        end
    end

    always @(*) begin
        next_state = state;
        next_pattern = pattern;
        next_delay = delay;
        next_counter = counter;
        next_count = count;
        next_bits_received = bits_received;
        counting = 1'b0;
        done = 1'b0;

        case (state)
            IDLE: begin
                next_pattern = {pattern[2:0], data};
                if (next_pattern == 4'b1101) begin
                    next_state = PATTERN_DETECTED;
                    next_bits_received = 3'b0;
                end
            end
            PATTERN_DETECTED: begin
                if (bits_received < 3) begin
                    next_delay = {delay[2:0], data};
                    next_bits_received = bits_received + 1;
                end else begin
                    next_delay = {delay[2:0], data};
                    next_state = LOAD_DELAY;
                end
            end
            LOAD_DELAY: begin
                next_counter = ((delay + 1) * 1000) - 1;
                next_count = delay;
                next_state = COUNTDOWN;
            end
            COUNTDOWN: begin
                counting = 1'b1;
                if (counter > 0) begin
                    next_counter = counter - 1;
                    if ((counter % 1000) == 0) begin
                        next_count = count - 1;
                    end
                end else begin
                    next_count = 4'b0;
                    next_state = DONE;
                end
            end
            DONE: begin
                done = 1'b1;
                if (ack) begin
                    next_state = IDLE;
                    next_pattern = 4'b0;
                    next_delay = 4'b0;
                    next_counter = 16'b0;
                    next_count = 4'b1111;
                    next_bits_received = 3'b0;
                end
            end
        endcase
    end
endmodule
