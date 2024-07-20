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

    reg [2:0] state, next_state;
    reg [3:0] pattern;
    reg [3:0] delay;
    reg [15:0] counter;  // Increased width to handle larger counts
    reg [2:0] bits_received;

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (pattern == 4'b1101)
                    next_state = PATTERN_DETECTED;
                else
                    next_state = IDLE;
            end
            PATTERN_DETECTED: begin
                if (bits_received == 3)
                    next_state = LOAD_DELAY;
                else
                    next_state = PATTERN_DETECTED;
            end
            LOAD_DELAY: begin
                next_state = COUNTDOWN;
            end
            COUNTDOWN: begin
                if (counter == 0)
                    next_state = DONE;
                else
                    next_state = COUNTDOWN;
            end
            DONE: begin
                if (ack)
                    next_state = IDLE;
                else
                    next_state = DONE;
            end
            default: next_state = IDLE;
        endcase
    end

    // Output and counter logic
    always @(posedge clk) begin
        if (reset) begin
            pattern <= 4'b0;
            delay <= 4'b0;
            counter <= 16'b0;
            count <= 4'b1111; // set to all 1's instead of 0 for don't-care
            counting <= 1'b0;
            done <= 1'b0;
            bits_received <= 3'b000;
        end else begin
            case (state)
                IDLE: begin
                    done <= 1'b0;
                    counting <= 1'b0;
                    pattern <= {pattern[2:0], data};
                end
                PATTERN_DETECTED: begin
                    bits_received <= bits_received + 1;
                    delay <= {delay[2:0], data};
                end
                LOAD_DELAY: begin
                    counter <= (delay + 1) * 1000 - 1;
                    count <= delay;
                    counting <= 1'b1;
                end
                COUNTDOWN: begin
                    if (counter > 0) begin
                        counter <= counter - 1;
                        if (counter[9:0] == 10'b0) begin
                            count <= count - 1;
                        end
                    end else begin
                        count <= 4'b0;
                        counting <= 1'b0;
                        done <= 1'b1;
                    end
                end
                DONE: begin
                    if (ack) begin
                        pattern <= 4'b0;
                        delay <= 4'b0;
                        counter <= 16'b0;
                        count <= 4'b1111; // don't-care value
                        counting <= 1'b0;
                        done <= 1'b0;
                        bits_received <= 3'b000;
                    end
                end
            endcase
        end
    end
endmodule
