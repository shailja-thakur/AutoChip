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
    reg [3:0] bits_received;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            pattern <= 4'b0;
            delay <= 4'b0;
            counter <= 16'b0;
            count <= 4'b1111; // set to all 1's instead of 0 for don't-care
            counting <= 1'b0;
            done <= 1'b0;
            bits_received <= 4'b0;
        end else begin
            state <= next_state;
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            pattern <= 4'b0;
            delay <= 4'b0;
            counter <= 16'b0;
            count <= 4'b1111; // set to all 1's instead of 0 for don't-care
            counting <= 1'b0;
            done <= 1'b0;
            bits_received <= 4'b0;
        end else begin
            case (state)
                IDLE: begin
                    pattern <= {pattern[2:0], data};
                    if (pattern == 4'b1101) begin
                        bits_received <= 0;
                    end
                end
                PATTERN_DETECTED: begin
                    if (bits_received < 4) begin
                        delay <= {delay[2:0], data};
                        bits_received <= bits_received + 1;
                    end
                end
                LOAD_DELAY: begin
                    counter <= (delay + 1) * 1000 - 1;
                    count <= delay;
                end
                COUNTDOWN: begin
                    if (counter > 0) begin
                        counter <= counter - 1;
                        if (counter[9:0] == 10'b0) begin
                            count <= count - 1;
                        end
                    end
                end
                DONE: begin
                    if (ack) begin
                        pattern <= 4'b0;
                        delay <= 4'b0;
                        counter <= 16'b0;
                        count <= 4'b1111; // don't-care
                        bits_received <= 4'b0;
                    end
                end
            endcase
        end
    end

    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                done = 1'b0;
                counting = 1'b0;
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
                counting = 1'b1;
                count = delay;
                next_state = COUNTDOWN;
            end
            COUNTDOWN: begin
                counting = 1'b1;
                if (counter == 0) begin
                    next_state = DONE;
                    counting = 1'b0;
                    done = 1'b1;
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
endmodule
