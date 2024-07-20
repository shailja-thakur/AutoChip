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
    typedef enum logic [2:0] {
        IDLE,
        PATTERN_DETECT,
        LOAD_DELAY,
        COUNTDOWN,
        WAIT_ACK
    } state_t;

    state_t state, next_state;

    reg [3:0] delay;
    reg [13:0] counter; // To count 0 to 9999 cycles (14 bits)

    // Sequential state transition
    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (data == 1'b1) // start detecting
                    next_state = PATTERN_DETECT;
                else
                    next_state = IDLE;
            end

            PATTERN_DETECT: begin
                // Detect 1101
                if ({data_reg[2:0], data} == 4'b1101)
                    next_state = LOAD_DELAY;
                else
                    next_state = IDLE;
            end

            LOAD_DELAY: begin
                if (delay_bits_shifted == 3)
                    next_state = COUNTDOWN;
                else
                    next_state = LOAD_DELAY;
            end

            COUNTDOWN: begin
                if (counter == 0)
                    next_state = WAIT_ACK;
                else
                    next_state = COUNTDOWN;
            end

            WAIT_ACK: begin
                if (ack)
                    next_state = IDLE;
                else
                    next_state = WAIT_ACK;
            end

            default: next_state = IDLE;
        endcase
    end

    reg [2:0] bit_cnt;
    reg [2:0] data_reg;
    reg [3:0] delay_cnt;

    always @(posedge clk) begin
        if (reset) begin
            data_reg  <= 3'b0;
            delay_cnt <= 4'b0;
            bit_cnt   <= 3'b0;
            delay     <= 4'b0;
            count     <= 4'b0;
            counter   <= 14'b0;
            done      <= 1'b0;
            counting  <= 1'b0;
        end
        else begin
            case (state)
                PATTERN_DETECT: begin
                    if (bit_cnt < 3) begin
                        bit_cnt <= bit_cnt + 1;
                        data_reg <= {data_reg[1:0], data};
                    end
                    else begin
                        data_reg <= {data_reg[1:0], data};
                        bit_cnt <= 0;
                    end
                end

                LOAD_DELAY: begin
                    delay <= {delay[2:0], data};
                    delay_cnt <= delay_cnt + 1;
                end

                COUNTDOWN: begin
                    counting <= 1'b1;
                    if (counter == 0) begin
                        if (delay == 0) begin
                            delay <= 4'b1111;
                            counting <= 1'b0;
                            done <= 1'b1;
                        end
                        else begin
                            delay <= delay - 4'b0001;
                            counter <= 14'd1000;
                        end
                    end
                    else begin
                        counter <= counter - 14'b1;
                    end
                end

                WAIT_ACK: begin
                    count <= 4'bxxxx;
                    if (ack) begin
                        done <= 1'b0;
                    end
                end
            endcase
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            counter <= 14'b0;
            count <= 4'b0;
        end
        else begin
            if (state == COUNTDOWN) begin
                if (counter == 14'd0) begin
                    count <= delay - 1;
                    counter <= 14'd1000;
                end
                else begin
                    count <= delay;
                end
            end
        end
    end
endmodule
