module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // Define states
    typedef enum logic [2:0] {
        WAIT_START,
        SHIFT_ENABLE,
        WAIT_COUNT,
        TIMER_DONE
    } state_type;

    // Define signals
    reg [2:0] state;
    reg [3:0] shift_counter;
    reg is_start_detected;

    // State machine logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= WAIT_START;
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
            shift_counter <= 0;
            is_start_detected <= 0;
        end else begin
            case (state)
                WAIT_START:
                    if (data == 4'b1101) begin
                        state <= SHIFT_ENABLE;
                        shift_ena <= 1;
                        shift_counter <= 0;
                    end
                SHIFT_ENABLE:
                    if (shift_counter >= 4) begin
                        state <= WAIT_COUNT;
                        shift_ena <= 0;
                        counting <= 1;
                        shift_counter <= 0;
                        is_start_detected <= 1;
                    end else begin
                        shift_counter <= shift_counter + 1;
                    end
                WAIT_COUNT:
                    if (done_counting) begin
                        state <= TIMER_DONE;
                        counting <= 0;
                        is_start_detected <= 0;
                        done <= 1;
                    end
                TIMER_DONE:
                    if (ack) begin
                        state <= WAIT_START;
                        done <= 0;
                    end
            endcase
        end
    end

endmodule
