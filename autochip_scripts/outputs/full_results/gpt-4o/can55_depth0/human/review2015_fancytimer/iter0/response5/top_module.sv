module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    // State encoding
    typedef enum reg [2:0] {
        IDLE, CHECK_1101, LOAD_DELAY, COUNTDOWN, WAIT_ACK
    } state_t;

    state_t current_state, next_state;

    // Pattern detection shift register
    reg [3:0] pattern_shift;

    // Timer registers
    reg [3:0] delay;
    reg [11:0] counter;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Next-state and output logic
    always @(*) begin
        next_state = current_state;
        counting = 0;
        done = 0;

        case (current_state)
            IDLE: begin
                pattern_shift = {pattern_shift[2:0], data};
                if (pattern_shift == 4'b1101) begin
                    next_state = CHECK_1101;
                end
            end

            CHECK_1101: begin
                delay[3:0] = {delay[2:0], data};
                if (pattern_shift == 4'b1101) begin
                    next_state = LOAD_DELAY;
                end
            end

            LOAD_DELAY: begin
                pattern_shift = {pattern_shift[2:0], data};
                if ((pattern_shift & 4'b1111) == 4'b1101) begin
                    delay = {delay[2:0], data};
                end else begin
                    next_state = COUNTDOWN;
                end
            end

            COUNTDOWN: begin
                counting = 1;
                if (counter == 0) begin
                    counter = (delay + 1) * 1000;
                end else begin
                    counter = counter - 1;
                end

                count = counter[11:8];

                if (counter == 0) begin
                    done = 1;
                    next_state = WAIT_ACK;
                end
            end

            WAIT_ACK: begin
                done = 1;
                if (ack) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

    // Handle synchronous reset of shift register
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pattern_shift <= 4'b0000;
        end else if (current_state == IDLE || current_state == CHECK_1101 || current_state == LOAD_DELAY) begin
            pattern_shift <= {pattern_shift[2:0], data};
        end
    end

    // Handle synchronous reset of delay register
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            delay <= 4'b0000;
        end
    end

    // Handle counter reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 12'b0;
        end else if (current_state == COUNTDOWN) begin
            counter <= counter - 1;
        end
    end

    // Increment counter
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 0;
        end else if (current_state == COUNTDOWN) begin
            if (counter == 0) begin
                counter <= (delay + 1) * 1000 - 1;
            end else begin
                counter <= counter - 1;
            end
        end
    end

endmodule
