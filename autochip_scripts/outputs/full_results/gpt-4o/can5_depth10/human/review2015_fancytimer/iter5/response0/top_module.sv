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

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            pattern <= 4'b0;
            delay <= 4'b0;
            counter <= 13'b0;
            count <= 4'b1111; // set to don't-care initially
            counting <= 1'b0;
            done <= 1'b0;
            bits_received <= 4'b0;
        end else begin
            state <= next_state;
            if (state == IDLE) begin
                pattern <= {pattern[2:0], data};
            end else if (state == PATTERN_DETECTED && bits_received < 4) begin
                delay <= {delay[2:0], data};
                bits_received <= bits_received + 1;
            end
        end
    end

    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                done = 1'b0;
                counting = 1'b0;
                count = 4'b1111; // set to don't-care initially
                if (pattern == 4'b1101) begin
                    next_state = PATTERN_DETECTED;
                    bits_received = 0;
                end
            end
            
            PATTERN_DETECTED: begin
                if (bits_received == 4) begin
                    next_state = LOAD_DELAY;
                end
            end
            
            LOAD_DELAY: begin
                counter = (delay + 1) * 1000;
                count = delay;
                counting = 1'b1;
                next_state = COUNTDOWN;
            end
            
            COUNTDOWN: begin
                done = 1'b0;
                if (counter > 0) begin
                    counter = counter - 1;
                    if (counter % 1000 == 0) begin
                        if (count > 0) begin
                            count = count - 1;
                        end
                    end
                end else begin
                    next_state = DONE;
                    counting = 1'b0;
                    done = 1'b1;
                end
            end
            
            DONE: begin
                if (ack) begin
                    next_state = IDLE;
                    pattern = 4'b0;
                    delay = 4'b0;
                    counter = 13'b0;
                    count = 4'b1111; // set to don't-care
                    counting = 1'b0;
                    done = 1'b0;
                    bits_received = 4'b0;
                end
            end
        endcase
    end
endmodule
