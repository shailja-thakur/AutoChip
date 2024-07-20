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
    enum {WAIT_FOR_PATTERN, SHIFT_IN_DATA, WAIT_FOR_COUNTERS, NOTIFY_USER, WAIT_FOR_ACK} state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset to the initial state
            state <= WAIT_FOR_PATTERN;
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
        end else begin
            case (state)
                WAIT_FOR_PATTERN:
                    if (data == 4'b1101) begin
                        state <= SHIFT_IN_DATA;
                        shift_ena <= 1;
                    end else begin
                        state <= WAIT_FOR_PATTERN;
                    end
                SHIFT_IN_DATA:
                    if (shift_ena) begin
                        state <= SHIFT_IN_DATA;
                    end else begin
                        state <= WAIT_FOR_COUNTERS;
                        counting <= 1;
                    end
                WAIT_FOR_COUNTERS:
                    if (done_counting) begin
                        state <= NOTIFY_USER;
                        counting <= 0;
                        done <= 1;
                    end else begin
                        state <= WAIT_FOR_COUNTERS;
                    end
                NOTIFY_USER:
                    if (ack) begin
                        state <= WAIT_FOR_PATTERN;
                        done <= 0;
                    end else begin
                        state <= NOTIFY_USER;
                    end
            endcase
        end
    end
endmodule
