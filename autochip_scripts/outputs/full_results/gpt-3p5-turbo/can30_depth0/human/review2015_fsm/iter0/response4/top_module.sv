module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack);

    reg [3:0] state; // State variable

    // State definitions
    parameter IDLE = 0;
    parameter DETECT_PATTERN = 1;
    parameter SHIFT_IN = 2;
    parameter WAITING = 3;
    parameter TIMED_OUT = 4;
    parameter WAIT_ACK = 5;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (data == 4'b1101)
                        state <= DETECT_PATTERN;
                end
                DETECT_PATTERN: begin
                    state <= SHIFT_IN;
                    shift_ena <= 1;
                end
                SHIFT_IN: begin
                    state <= WAITING;
                    shift_ena <= 0;
                end
                WAITING: begin
                    if (done_counting)
                        state <= TIMED_OUT;
                    counting <= 1;
                end
                TIMED_OUT: begin
                    state <= WAIT_ACK;
                    done <= 1;
                end
                WAIT_ACK: begin
                    if (ack)
                        state <= IDLE;
                end
                default: begin
                    state <= IDLE;
                end
            endcase
        end
    end
endmodule
