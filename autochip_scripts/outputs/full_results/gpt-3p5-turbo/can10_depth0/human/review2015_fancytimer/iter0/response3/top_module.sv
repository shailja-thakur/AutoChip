module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [3:0] timer_count;
    reg [3:0] remaining_time;
    reg start_sequence_detected;
    reg [2:0] state;

    parameter IDLE = 0;
    parameter DETECT_START_SEQUENCE = 1;
    parameter SHIFT_IN_DELAY = 2;
    parameter COUNT = 3;
    parameter WAIT_FOR_ACK = 4;
    parameter RESET_STATE = 5;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= RESET_STATE;
            start_sequence_detected <= 0;
            counting <= 0;
            done <= 0;
            delay <= 0;
            remaining_time <= 0;
            timer_count <= 0;
        end else begin
            case (state)
                IDLE:
                    if (data == 1) begin
                        state <= DETECT_START_SEQUENCE;
                    end
                DETECT_START_SEQUENCE:
                    if (data == 0) begin
                        state <= IDLE;
                        start_sequence_detected <= 0;
                    end else if (timer_count < 4 && data == 1) begin
                        timer_count <= timer_count + 1;
                        start_sequence_detected <= (timer_count == 3);
                    end else if (timer_count == 4) begin
                        start_sequence_detected <= 1;
                        delay <= data;
                        timer_count <= 0;
                        state <= SHIFT_IN_DELAY;
                    end
                SHIFT_IN_DELAY:
                    state <= COUNT;
                COUNT:
                    counting <= 1;
                    if (remaining_time == 0) begin
                        state <= WAIT_FOR_ACK;
                        counting <= 0;
                        done <= 1;
                    end
                    remaining_time <= remaining_time - 1;
                WAIT_FOR_ACK:
                    if (ack) begin
                        state <= IDLE;
                        start_sequence_detected <= 0;
                    end
                RESET_STATE:
                    state <= IDLE;
                    start_sequence_detected <= 0;
            endcase
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            count <= 0;
        end else if (state == COUNT) begin
            count <= remaining_time;
        end else begin
            count <= 0;
        end
    end
endmodule
