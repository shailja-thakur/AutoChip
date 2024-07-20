module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    // State definitions
    typedef enum reg [2:0] {
        IDLE = 3'b000,
        CHECK_SEQ = 3'b001,
        LOAD_DELAY = 3'b010,
        COUNTING = 3'b011,
        WAIT_ACK = 3'b100
    } state_t;
    
    state_t state, next_state;

    reg [3:0] shift_reg;
    reg [3:0] delay;
    reg [9:0] cycle_count;
    reg [3:0] count_reg;

    assign count = counting ? count_reg : 4'bxxxx;

    // Shift register to detect 1101 sequence and load delay
    always @(posedge clk) begin
        if (reset) begin
            shift_reg <= 4'b0;
        end else if (state == CHECK_SEQ || state == LOAD_DELAY) begin
            shift_reg <= {shift_reg[2:0], data};
        end
    end

    // State transition
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: 
                next_state = CHECK_SEQ;

            CHECK_SEQ: 
                if (shift_reg == 4'b1101)
                    next_state = LOAD_DELAY;
                else
                    next_state = CHECK_SEQ;

            LOAD_DELAY: 
                if (shift_reg == 4'b1101)
                    next_state = COUNTING;
                else
                    next_state = LOAD_DELAY;

            COUNTING: 
                if (cycle_count == 0)
                    next_state = WAIT_ACK;
                else
                    next_state = COUNTING;

            WAIT_ACK: 
                if (ack)
                    next_state = IDLE;
                else
                    next_state = WAIT_ACK;

            default: 
                next_state = IDLE;
        endcase
    end

    // Output logic and internal counters
    always @(posedge clk) begin
        if (reset) begin
            counting <= 0;
            done <= 0;
            cycle_count <= 0;
            count_reg <= 0;
            delay <= 4'b0;

        end else begin
            case (state)
                IDLE: begin
                    counting <= 0;
                    done <= 0;
                end

                CHECK_SEQ: begin
                    counting <= 0;
                    done <= 0;
                end

                LOAD_DELAY: begin
                    counting <= 0;
                    done <= 0;
                    delay <= shift_reg;
                end

                COUNTING: begin
                    counting <= 1;
                    done <= 0;
                    if (cycle_count == 0) begin
                        cycle_count <= (delay + 1) * 1000 - 1;
                        count_reg <= delay;
                    end else begin
                        cycle_count <= cycle_count - 1;
                        if (cycle_count[9:0] % 1000 == 0)
                            count_reg <= count_reg - 1;
                    end
                end

                WAIT_ACK: begin
                    counting <= 0;
                    done <= 1;
                    if (ack) begin
                        done <= 0;
                    end
                end
            endcase
        end
    end

endmodule
