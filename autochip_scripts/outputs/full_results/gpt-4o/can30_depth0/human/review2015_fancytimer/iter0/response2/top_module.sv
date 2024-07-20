module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    typedef enum {IDLE, DETECT_1101, READ_DELAY, COUNTDOWN, WAIT_ACK} state_t;
    state_t state, next_state;

    reg [3:0] shift_reg;
    reg [3:0] delay;
    reg [13:0] timer_count;
    reg [10:0] cycle_count;
    reg [2:0] bit_counter;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            shift_reg <= 4'b0000;
            delay <= 4'b0000;
            count <= 4'b0000;
            timer_count <= 14'd1000;
            cycle_count <= 11'd1000;
            bit_counter <= 3'd0;
            counting <= 0;
            done <= 0;
        end else begin
            state <= next_state;

            case (state)
                IDLE: begin
                    shift_reg <= 4'b0000;
                    timer_count <= 14'd1000;
                    cycle_count <= 11'd1000;
                    bit_counter <= 3'd0;
                    count <= 4'b0000;
                    counting <= 0;
                    done <= 0;
                end
                DETECT_1101: begin
                    shift_reg <= {shift_reg[2:0], data};
                end
                READ_DELAY: begin
                    shift_reg <= {shift_reg[2:0], data};
                    if (bit_counter == 3'd3) begin
                        delay <= {shift_reg[2:0], data};
                        timer_count <= {13'd1000} * (shift_reg + 1);
                        cycle_count <= 11'd1000;
                        count <= delay;
                        counting <= 1;
                    end else begin
                        bit_counter <= bit_counter + 1;
                    end
                end
                COUNTDOWN: begin
                    count <= (timer_count / 1000) - 1;
                    if (cycle_count == 0) begin
                        if (timer_count == 0) begin
                            counting <= 0;
                            done <= 1;
                        end else begin
                            timer_count <= timer_count - 14'd1000;
                            cycle_count <= 11'd1000;
                        end
                    end else begin
                        cycle_count <= cycle_count - 1;
                    end
                end
                WAIT_ACK: begin
                    if (ack) begin
                        done <= 0;
                    end
                end
            endcase
        end
    end

    always @(*) begin
        next_state = state;
        case (state)
            IDLE: 
                if (shift_reg == 4'b1101) 
                    next_state = READ_DELAY;
                else 
                    next_state = DETECT_1101;
            DETECT_1101: 
                if (shift_reg[3:0] == 4'b1101)
                    next_state = READ_DELAY;
                else
                    next_state = DETECT_1101;
            READ_DELAY: 
                if (bit_counter == 3'd3)
                    next_state = COUNTDOWN;
                else
                    next_state = READ_DELAY;
            COUNTDOWN: 
                if (timer_count == 0 && cycle_count == 0)
                    next_state = WAIT_ACK;
                else
                    next_state = COUNTDOWN;
            WAIT_ACK: 
                if (ack) 
                    next_state = IDLE;
                else 
                    next_state = WAIT_ACK;
            default: 
                next_state = IDLE;
        endcase
    end

endmodule
