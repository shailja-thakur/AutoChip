module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // State encoding
    typedef enum reg [2:0] {
        IDLE,            // Waiting for pattern 1101
        PATTERN_DETECT,  // Pattern 1101 detected
        SHIFT,           // Shifting in duration bits
        COUNT,           // Waiting for counters
        DONE,            // Timer done, waiting for ack
        WAIT_ACK         // Waiting for ack from user
    } state_t;

    state_t state, next_state;
    reg [3:0] shift_counter;
    reg [3:0] pattern_shift_reg;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
            shift_counter <= 0;
            pattern_shift_reg <= 0;
        end else begin
            state <= next_state;

            case (state)
                IDLE: begin
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 0;
                    // Shift in the data bit for pattern detection
                    pattern_shift_reg <= {pattern_shift_reg[2:0], data};
                end
                
                PATTERN_DETECT: begin
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 0;
                end

                SHIFT: begin
                    shift_ena <= 1;
                    counting <= 0;
                    done <= 0;
                    shift_counter <= shift_counter + 1;
                end

                COUNT: begin
                    shift_ena <= 0;
                    counting <= 1;
                    done <= 0;
                end

                DONE: begin
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 1;
                end
                
                WAIT_ACK: begin
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 0;
                end

                default: begin
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 0;
                end
            endcase

        end
    end

    always @(*) begin
        next_state = state;

        case (state)
            IDLE: begin
                if (pattern_shift_reg == 4'b1101)
                    next_state = PATTERN_DETECT;
            end

            PATTERN_DETECT: begin
                next_state = SHIFT;
                shift_counter = 0;
            end

            SHIFT: begin
                if (shift_counter == 4)
                    next_state = COUNT;
            end

            COUNT: begin
                if (done_counting)
                    next_state = DONE;
            end

            DONE: begin
                if (ack)
                    next_state = IDLE;
                else
                    next_state = WAIT_ACK;
            end

            WAIT_ACK: begin
                if (ack)
                    next_state = IDLE;
            end

            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule
