module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    // State encoding
    localparam [2:0] 
        IDLE = 3'b000,
        PATTERN_DETECTED = 3'b001,
        LOAD_DELAY = 3'b010,
        COUNTDOWN = 3'b011,
        DONE = 3'b100;

    reg [2:0] state, next_state;
    reg [3:0] pattern;
    reg [3:0] delay;
    reg [12:0] counter;  // 13 bits to handle larger counts

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            pattern <= 4'b0;
            delay <= 4'b0;
            counter <= 13'b0;
            count <= 4'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            pattern <= 4'b0;
        end else if (state == IDLE || state == PATTERN_DETECTED) begin
            pattern <= {pattern[2:0], data};
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            delay <= 4'b0;
        end else if (state == PATTERN_DETECTED && bits_received < 4) begin
            delay <= {delay[2:0], data};
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 13'b0;
        end else if (state == LOAD_DELAY) begin
            counter <= (delay + 1) * 1000 - 1;
        end else if (state == COUNTDOWN && counter > 0) begin
            counter <= counter - 1;
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 4'b0;
        end else if (state == LOAD_DELAY) begin
            count <= delay;
        end else if (state == COUNTDOWN && counter[9:0] == 0 && count > 0) begin
            count <= count - 1;
        end
    end

    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                next_state = (pattern == 4'b1101) ? PATTERN_DETECTED : IDLE;
            end
            PATTERN_DETECTED: begin
                next_state = (bits_received == 4) ? LOAD_DELAY : PATTERN_DETECTED;
            end
            LOAD_DELAY: begin
                next_state = COUNTDOWN;
            end
            COUNTDOWN: begin
                next_state = (counter == 0) ? DONE : COUNTDOWN;
            end
            DONE: begin
                next_state = (ack) ? IDLE : DONE;
            end
        endcase
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            counting <= (state == COUNTDOWN);
            done <= (state == DONE);
        end
    end

    reg [3:0] bits_received;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            bits_received <= 4'b0;
        end else if (state == PATTERN_DETECTED && bits_received < 4) begin
            bits_received <= bits_received + 1;
        end else if (state == IDLE) begin
            bits_received <= 4'b0;
        end 
    end

endmodule
