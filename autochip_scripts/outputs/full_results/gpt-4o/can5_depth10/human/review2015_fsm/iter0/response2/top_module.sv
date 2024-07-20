module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack
);

    // State declaration
    typedef enum reg [2:0] {
        IDLE,
        DETECT_1,
        DETECT_11,
        DETECT_110,
        DETECT_1101,
        SHIFT,
        WAIT_COUNT,
        DONE
    } state_t;

    state_t state, next_state;

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next-state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (data == 1)
                    next_state = DETECT_1;
                else
                    next_state = IDLE;
            end
            DETECT_1: begin
                if (data == 1)
                    next_state = DETECT_11;
                else
                    next_state = IDLE;
            end
            DETECT_11: begin
                if (data == 0)
                    next_state = DETECT_110;
                else
                    next_state = IDLE;
            end
            DETECT_110: begin
                if (data == 1)
                    next_state = DETECT_1101;
                else
                    next_state = IDLE;
            end
            DETECT_1101: begin
                next_state = SHIFT;
            end
            SHIFT: begin
                if (shift_counter == 4)
                    next_state = WAIT_COUNT;
                else
                    next_state = SHIFT;
            end
            WAIT_COUNT: begin
                if (done_counting)
                    next_state = DONE;
                else
                    next_state = WAIT_COUNT;
            end
            DONE: begin
                if (ack)
                    next_state = IDLE;
                else
                    next_state = DONE;
            end
            default: next_state = IDLE;
        endcase
    end

    // Output logic and shift counter
    reg [2:0] shift_counter;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
            shift_counter <= 0;
        end
        else begin
            case (state)
                IDLE: begin
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 0;
                    shift_counter <= 0;
                end
                DETECT_1, DETECT_11, DETECT_110, DETECT_1101: begin
                    shift_ena <= 0;
                end
                SHIFT: begin
                    shift_ena <= 1;
                    shift_counter <= shift_counter + 1;
                end
                WAIT_COUNT: begin
                    shift_ena <= 0;
                    counting <= 1;
                end
                DONE: begin
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 1;
                end
            endcase
        end
    end

endmodule
