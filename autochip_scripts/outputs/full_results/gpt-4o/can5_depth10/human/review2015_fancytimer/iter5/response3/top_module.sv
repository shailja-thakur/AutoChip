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
    reg [12:0] counter;
    reg [3:0] bits_received;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic and outputs
    always @(*) begin
        // Default values
        next_state = state;
        counting = 1'b0;
        done = 1'b0;
        case (state)
            IDLE: begin
                if (pattern == 4'b1101) begin
                    next_state = PATTERN_DETECTED;
                end
            end
            PATTERN_DETECTED: begin
                if (bits_received == 4) begin
                    next_state = LOAD_DELAY;
                end
            end
            LOAD_DELAY: begin
                next_state = COUNTDOWN;
            end
            COUNTDOWN: begin
                counting = 1'b1;
                if (counter == 0) begin
                    next_state = DONE;
                end
            end
            DONE: begin
                done = 1'b1;
                if (ack) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

    // Manage Pattern and delay loading
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pattern <= 4'b0000;
            delay <= 4'b0000;
            bits_received <= 4'b0000;
        end else begin
            case (state)
                IDLE: begin
                    pattern <= {pattern[2:0], data};
                end
                PATTERN_DETECTED: begin
                    if (bits_received < 4) begin
                        delay <= {delay[2:0], data};
                        bits_received <= bits_received + 1;
                    end
                end
                LOAD_DELAY: begin
                    bits_received <= 4'b0000;
                end
                DONE: begin
                    pattern <= 4'b0000;
                end
                default: ;
            endcase
        end
    end

    // Countdown logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 13'b0;
            count <= 4'b1111;
        end else begin
            case (state)
                LOAD_DELAY: begin
                    counter <= (delay + 1) * 1000;
                    count <= delay;
                end
                COUNTDOWN: begin
                    if (counter > 0) begin
                        counter <= counter - 1;
                        if (counter % 1000 == 0) begin
                            count <= count - 1;
                        end
                    end
                end
                DONE: begin
                    count <= 4'b1111;
                end
                default: ;
            endcase
        end
    end
endmodule
