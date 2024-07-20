module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    typedef enum reg [2:0] {
        IDLE = 3'b000,
        PATTERN_DETECTED = 3'b001,
        SHIFT_DELAY = 3'b010,
        COUNTING = 3'b011,
        DONE = 3'b100,
        WAIT_ACK = 3'b101
    } state_t;
    
    state_t state, next_state;
    reg [2:0] pattern_cnt;
    reg [3:0] delay;
    reg [12:0] cycle_cnt;

    // Synchronize reset
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // State transition logic
    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                done = 0;
                counting = 0;
                if (!reset && pattern_cnt == 4'b1101) begin
                    next_state = PATTERN_DETECTED;
                end
            end

            PATTERN_DETECTED: begin
                if (pattern_cnt == 3) begin
                    next_state = SHIFT_DELAY;
                end
            end

            SHIFT_DELAY: begin
                if (pattern_cnt == 7) begin
                    next_state = COUNTING;
                end
            end

            COUNTING: begin
                counting = 1;
                if (cycle_cnt == 0 && count == 0) begin
                    next_state = DONE;
                end
            end

            DONE: begin
                counting = 0;
                done = 1;
                if (ack) begin
                    next_state = IDLE;
                end
            end

            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // Output logic and internal counters
    always @(posedge clk) begin
        if (reset) begin
            pattern_cnt <= 0;
            cycle_cnt <= 0;
            count <= 4'b1111; // convenient don't-care value
            delay <= 0;
        end else begin
            case (state)

                IDLE: begin
                    if (data && pattern_cnt < 4) begin
                        pattern_cnt <= pattern_cnt + 1;
                    end else if (pattern_cnt != 0) begin
                        pattern_cnt <= 0;
                    end
                end

                PATTERN_DETECTED: begin
                    if (pattern_cnt < 3) begin
                        pattern_cnt <= pattern_cnt + 1;
                    end else begin
                        pattern_cnt <= 0; // Reset pattern counter for delay shift
                    end
                end

                SHIFT_DELAY: begin
                    if (pattern_cnt < 7) begin
                        delay <= {delay[2:0], data};
                        pattern_cnt <= pattern_cnt + 1;
                    end else begin
                        count <= delay;
                        cycle_cnt <= 1000;
                    end
                end

                COUNTING: begin
                    if (cycle_cnt > 0) begin
                        cycle_cnt <= cycle_cnt - 1;
                    end else if (count > 0) begin
                        count <= count - 1;
                        cycle_cnt <= 1000;
                    end
                end

                DONE: begin
                    if (ack) begin
                        pattern_cnt <= 0;
                    end
                end

                default: begin
                    pattern_cnt <= 0;
                    cycle_cnt <= 0;
                    count <= 4'b1111; // convenient don't-care value
                    delay <= 0;
                end
            endcase
        end
    end

endmodule
