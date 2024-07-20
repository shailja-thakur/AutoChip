module top_module (
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    // State encoding
    typedef enum reg [2:0] {
        IDLE,
        DETECT_1,
        DETECT_11,
        DETECT_110,
        DETECT_1101,
        READ_DELAY,
        COUNTING,
        DONE
    } state_t;

    state_t state, next_state;
    reg [3:0] shift_reg;
    reg [3:0] delay;
    reg [15:0] timer_counter;
    reg [3:0] count_reg;

    assign count = counting ? count_reg : 4'bxxxx;

    // State transition
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // State machine
    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                if (data == 1'b1) next_state = DETECT_1;
            end
            DETECT_1: begin
                next_state = (data == 1'b1) ? DETECT_11 : IDLE;
            end
            DETECT_11: begin
                next_state = (data == 1'b0) ? DETECT_110 : IDLE;
            end
            DETECT_110: begin
                next_state = (data == 1'b1) ? DETECT_1101 : IDLE;
            end
            DETECT_1101: next_state = READ_DELAY;
            READ_DELAY: if (shift_reg[3:0] != 4'b0000) next_state = COUNTING;
            COUNTING: if (timer_counter == 16'd0) next_state = DONE;
            DONE: if (ack == 1'b1) next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            shift_reg <= 4'b0;
            delay <= 4'b0;
            timer_counter <= 16'b0;
            count_reg <= 4'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    shift_reg <= 4'b0;
                    delay <= 4'b0;
                    timer_counter <= 16'b0;
                    count_reg <= 4'b0;
                    counting <= 1'b0;
                    done <= 1'b0;
                end
                DETECT_1, DETECT_11, DETECT_110, DETECT_1101: begin
                    shift_reg <= {shift_reg[2:0], data};
                end
                READ_DELAY: begin
                    if (shift_reg[3:1] == 3'b110 && shift_reg[0] == 1'b1) begin
                        delay <= {shift_reg[2:0], data};
                    end
                end
                COUNTING: begin
                    if (timer_counter > 0) begin
                        timer_counter <= timer_counter - 1;
                        if (timer_counter % 1000 == 0) count_reg <= count_reg - 1;
                    end
                    if (timer_counter == 0) begin
                        counting <= 1'b0;
                        done <= 1'b1;
                    end
                end
                DONE: begin
                    if (ack) begin
                        done <= 1'b0;
                    end
                end
                default: begin
                    counting <= 1'b0;
                    done <= 1'b0;
                end
            endcase
        end
    end

    // Timer logic
    always @(posedge clk) begin
        if (reset) begin
            timer_counter <= 16'd0;
            counting <= 1'b0;
        end else if (state == READ_DELAY) begin
            timer_counter <= (delay + 1) * 1000;
            count_reg <= delay;
            counting <= 1'b1;
        end
    end
endmodule
