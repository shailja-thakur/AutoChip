module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] pattern;
    reg [3:0] delay;
    reg [12:0] counter;
    reg [2:0] state;
    reg [3:0] bits_received;

    localparam IDLE = 3'b000,
               PATTERN_DETECTED = 3'b001,
               LOAD_DELAY = 3'b010,
               COUNTDOWN = 3'b011,
               DONE = 3'b100;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            pattern <= 4'b0;
            delay <= 4'b0;
            counter <= 13'b0;
            count <= 4'b1111; // set to all 1's instead of 0 for don't-care
            counting <= 1'b0;
            done <= 1'b0;
            bits_received <= 4'b0;
        end else begin
            case (state)
                IDLE: begin
                    done <= 1'b0;
                    counting <= 1'b0;
                    count <= 4'b1111; // don't-care state for count output
                    pattern <= {pattern[2:0], data}; 
                    if (pattern == 4'b1101 && data == 1'b1) begin  // ensure complete pattern match
                        state <= PATTERN_DETECTED;
                        bits_received <= 0;
                    end
                end
                PATTERN_DETECTED: begin
                    if (bits_received < 4) begin
                        delay <= {delay[2:0], data};
                        bits_received <= bits_received + 1;
                    end 
                    if (bits_received == 3) begin
                        state <= LOAD_DELAY;
                    end
                end
                LOAD_DELAY: begin
                    counter <= (delay + 1) * 1000;
                    count <= delay;
                    counting <= 1'b1;
                    state <= COUNTDOWN;
                end
                COUNTDOWN: begin
                    if (counter > 0) begin
                        if (counter % 1000 == 0 && delay != 4'b0) begin
                            count <= count - 1;
                        end
                        counter <= counter - 1;
                    end else if (counter == 0) begin
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
                        counter <= 13'b0;
                        count <= 4'b1111; // don't-care state for count output
                        counting <= 1'b0;
                        done <= 1'b0;
                        bits_received <= 4'b0;
                    end
                end
            endcase
        end
    end
endmodule
