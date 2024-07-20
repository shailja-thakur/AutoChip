module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    // State encoding
    localparam IDLE = 3'b000,
               PATTERN_DETECTED = 3'b001,
               LOAD_DELAY = 3'b010,
               COUNTDOWN = 3'b011,
               DONE = 3'b100;

    reg [2:0] state;
    reg [3:0] pattern;
    reg [3:0] delay;
    reg [9:0] bit_counter;  // 10-bit to count up to 1000
    reg [3:0] remaining_delay;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            pattern <= 4'b0;
            delay <= 4'b0;
            bit_counter <= 10'b0;
            count <= 4'b1111; // set to all 1's instead of 0 for don't-care
            counting <= 1'b0;
            done <= 1'b0;
            remaining_delay <= 4'b1111;
        end else begin
            case (state)
                IDLE: begin
                    done <= 1'b0;
                    counting <= 1'b0;
                    pattern <= {pattern[2:0], data};
                    if (pattern == 4'b1101) begin
                        state <= PATTERN_DETECTED;
                    end
                end
                PATTERN_DETECTED: begin
                    delay <= {delay[2:0], data};
                    if (pattern == 4) begin
                        state <= LOAD_DELAY;
                    end else begin
                        pattern <= pattern - 1;
                    end
                end
                LOAD_DELAY: begin
                    remaining_delay <= delay;
                    bit_counter <= 10'b1111111111;
                    count <= delay;
                    counting <= 1'b1;
                    state <= COUNTDOWN;
                end
                COUNTDOWN: begin
                    if (bit_counter > 0) begin
                        bit_counter <= bit_counter - 1;
                    end else if (remaining_delay > 0) begin
                        remaining_delay <= remaining_delay - 1;
                        bit_counter <= 10'b1111111111;
                        count <= remaining_delay - 1;
                    end else begin
                        state <= DONE;
                        counting <= 1'b0;
                        done <= 1'b1;
                    end
                end
                DONE: begin
                    if (ack) begin
                        state <= IDLE;
                        pattern <= 4'b0;
                        delay <= 4'b0;
                        bit_counter <= 10'b0;
                        count <= 4'b1111;
                        counting <= 1'b0;
                        done <= 1'b0;
                        remaining_delay <= 4'b1111;
                    end
                end
            endcase
        end
    end
endmodule
