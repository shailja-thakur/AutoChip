module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    // State definitions
    typedef enum reg [2:0] {
        IDLE,
        READ_PATTERN,
        READ_DELAY,
        COUNTING,
        WAIT_FOR_ACK
    } state_t;
    state_t state, next_state;

    // Internal registers
    reg [3:0] shift_reg;
    reg [1:0] bit_cnt;
    reg [3:0] delay;
    reg [15:0] cycle_cnt; // Counts up to 1000 cycles for each delay step

    // Next state logic, sequential logic
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Shift register for data input
    always @(posedge clk) begin
        if (reset) begin
            shift_reg <= 4'b0;
            bit_cnt <= 2'b0;
        end else if (state == READ_PATTERN || state == READ_DELAY) begin
            shift_reg <= {shift_reg[2:0], data};
            bit_cnt <= bit_cnt + 2'b1;
        end else if (state != READ_PATTERN && state != READ_DELAY) begin
            bit_cnt <= 2'b0;
        end
    end

    // Cycle counter
    always @(posedge clk) begin
        if (reset || state != COUNTING) begin
            cycle_cnt <= 16'b0;
        end else if (state == COUNTING) begin
            if (cycle_cnt < 16'd999) begin
                cycle_cnt <= cycle_cnt + 1;
            end else begin
                cycle_cnt <= 16'b0;
            end
        end
    end

    // Output and state logic
    always @(*) begin
        next_state = state;
        counting = 1'b0;
        done = 1'b0;
        count = 4'b0;

        case (state)
            IDLE: begin
                if (bit_cnt == 2'b0)
                    next_state = READ_PATTERN;
                else
                    next_state = IDLE;
            end
            READ_PATTERN: begin
                if (shift_reg == 4'b1101 && bit_cnt == 2'd3) begin
                    next_state = READ_DELAY;
                end else if (bit_cnt == 2'd3) begin
                    next_state = IDLE;
                end else begin
                    next_state = READ_PATTERN;
                end
            end
            READ_DELAY: begin
                if (bit_cnt == 2'd3) begin
                    delay = shift_reg;
                    next_state = COUNTING;
                end else begin
                    next_state = READ_DELAY;
                end
            end
            COUNTING: begin
                counting = 1'b1;
                if (cycle_cnt == 16'd999) begin
                    if (delay == 4'b0) begin
                        done = 1'b1;
                        next_state = WAIT_FOR_ACK;
                    end else begin
                        delay = delay - 1;
                        cycle_cnt = 16'b0;
                    end
                end
                count = delay;
            end
            WAIT_FOR_ACK: begin
                done = 1'b1;
                if (ack) begin
                    next_state = IDLE;
                end else begin
                    next_state = WAIT_FOR_ACK;
                end
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end
endmodule
