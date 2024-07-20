module top_module (
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);
    // State declaration
    typedef enum reg [2:0] {
        IDLE,
        DETECT_1,
        DETECT_11,
        DETECT_110,
        DETECT_1101,
        READ_DELAY,
        COUNT_DELAY,
        WAIT_ACK
    } state_t;

    state_t state, next_state;

    reg [3:0] delay;
    reg [15:0] cycle_count;
    reg [3:0] remaining_count;

    // State transition
    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // State logic
    always @(*) begin
        next_state = state;
        done = 1'b0;
        counting = 1'b0;

        case (state)
            IDLE: begin
                if (data)
                    next_state = DETECT_1;
            end

            DETECT_1: begin
                if (data)
                    next_state = DETECT_11;
                else
                    next_state = IDLE;
            end

            DETECT_11: begin
                if (data)
                    next_state = DETECT_110;
                else
                    next_state = IDLE;
            end

            DETECT_110: begin
                if (data)
                    next_state = DETECT_1101;
                else
                    next_state = IDLE;
            end

            DETECT_1101: begin
                if (data)
                    next_state = READ_DELAY;
                else
                    next_state = IDLE;
            end

            READ_DELAY: begin
                if (delay_load_done)
                    next_state = COUNT_DELAY;
            end

            COUNT_DELAY: begin
                counting = 1'b1;
                if (cycle_count == 0)
                    next_state = WAIT_ACK;
            end

            WAIT_ACK: begin
                done = 1'b1;
                if (ack)
                    next_state = IDLE;
            end
        endcase
    end

    // Delay loading logic
    reg [2:0] delay_bit_cnt;
    wire delay_load_done = (delay_bit_cnt == 3'd3);

    always @(posedge clk) begin
        if (reset) begin
            delay <= 4'd0;
            delay_bit_cnt <= 3'd0;
        end else if (state == DETECT_1101 || state == READ_DELAY) begin
            delay <= {delay[2:0], data};
            delay_bit_cnt <= delay_bit_cnt + 1;
        end else if (state == IDLE) begin
            delay_bit_cnt <= 3'd0;
        end
    end

    // Timer counting logic
    always @(posedge clk) begin
        if (reset) begin
            cycle_count <= 16'd0;
            remaining_count <= 4'd0;
        end else if (state == COUNT_DELAY) begin
            if (cycle_count == 16'd0) begin
                cycle_count <= 1000 - 1; // Each interval is 1000 cycles
                if (remaining_count != 4'd0)
                    remaining_count <= remaining_count - 1;
            end else begin
                cycle_count <= cycle_count - 1;
            end
        end else if (state == READ_DELAY) begin
            cycle_count <= 1000 - 1;
            remaining_count <= delay;
        end
    end

    // count output logic
    always @(*) begin
        if (state == COUNT_DELAY)
            count = remaining_count;
        else
            count = 4'dx; // don't-care
    end

endmodule
