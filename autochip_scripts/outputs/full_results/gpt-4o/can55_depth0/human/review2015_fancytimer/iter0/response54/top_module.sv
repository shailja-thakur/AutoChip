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
        CHECK_PATTERN,
        READ_DELAY,
        COUNTING,
        WAIT_ACK
    } state_t;

    reg [2:0] state, next_state;
    reg [3:0] shift_reg;
    reg [3:0] delay;
    reg [12:0] cycle_count; // 13 bits to count up to 8000 clock cycles

    wire pattern_detected = (shift_reg == 4'b1101);

    // State transitions
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case(state)
            IDLE: begin
                if (pattern_detected) begin
                    next_state = READ_DELAY;
                end else begin
                    next_state = IDLE;
                end
            end
            READ_DELAY: begin
                if (delay_ready) begin
                    next_state = COUNTING;
                end else begin
                    next_state = READ_DELAY;
                end
            end
            COUNTING: begin
                if (cycle_count == 0) begin
                    next_state = WAIT_ACK;
                end else begin
                    next_state = COUNTING;
                end
            end
            WAIT_ACK: begin
                if (ack) begin
                    next_state = IDLE;
                end else begin
                    next_state = WAIT_ACK;
                end
            end
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_reg <= 4'b0;
            delay <= 4'b0;
            cycle_count <= 13'b0;
            counting <= 0;
            done <= 0;
        end else begin
            case(state)
                IDLE: begin
                    shift_reg <= {shift_reg[2:0], data};
                    delay <= 4'b0;
                    cycle_count <= 13'b0;
                    counting <= 0;
                    done <= 0;
                end
                READ_DELAY: begin
                    delay <= {delay[2:0], data};
                    if (delay_read) begin
                        cycle_count <= (delay + 1) * 1000 - 1;
                    end
                end
                COUNTING: begin
                    if (cycle_count > 0) begin
                        cycle_count <= cycle_count - 1;
                        counting <= 1;
                        if (cycle_count % 1000 == 0) begin
                            count <= (cycle_count / 1000) - 1;
                        end
                    end else begin
                        counting <= 0;
                        done <= 1;
                    end
                end
                WAIT_ACK: begin
                    if (ack) begin
                        done <= 0;
                        count <= 4'bxxxx;
                    end
                end
            endcase
        end
    end

endmodule
