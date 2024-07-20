module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack);

    // State encoding
    localparam IDLE = 3'b000,
               PATTERN_DETECTED = 3'b001,
               LOAD_DELAY = 3'b010,
               COUNTDOWN = 3'b011,
               DONE = 3'b100;

    reg [2:0] state, next_state;
    reg [3:0] pattern;
    reg [3:0] delay;
    reg [15:0] counter;
    reg [2:0] bits_received;

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
            if (state == IDLE) 
                pattern <= {pattern[2:0], data};
            if (state == PATTERN_DETECTED && bits_received < 3) 
                delay <= {delay[2:0], data};
            if (state == LOAD_DELAY) 
                delay <= {delay[2:0], data};
            if (state == COUNTDOWN) 
                counter <= counter - 1;
            count <= next_state == COUNTDOWN ? counter / 1000 : 4'b1111;
            counting <= next_state == COUNTDOWN;
            done <= next_state == DONE;
            bits_received <= state == IDLE ? 3'b0 : (state == PATTERN_DETECTED ? bits_received + 1 : bits_received);
        end
    end

    always @(*) begin
        case (state)
            IDLE: next_state = (pattern == 4'b1101) ? PATTERN_DETECTED : IDLE;
            PATTERN_DETECTED: next_state = (bits_received == 3) ? LOAD_DELAY : PATTERN_DETECTED;
            LOAD_DELAY: next_state = COUNTDOWN;
            COUNTDOWN: next_state = (counter == 0) ? DONE : COUNTDOWN;
            DONE: next_state = ack ? IDLE : DONE;
            default: next_state = IDLE;
        endcase
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 4'b1111;  // use a default value for don't-care situations
        end else if (state == COUNTDOWN) begin
            // During countdown, set the count to the remaining time in terms of 1000s of clock cycles
            count <= counter / 1000;
        end else begin
            count <= 4'b1111;  // use a default value for don't-care situations
        end
    end
endmodule
