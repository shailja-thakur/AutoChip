module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    reg [3:0] state;

    parameter IDLE = 0;
    parameter DETECT_START = 1;
    parameter SHIFT_IN = 2;
    parameter WAIT_COUNTING = 3;
    parameter NOTIFY = 4;
    parameter WAIT_ACK = 5;

    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else begin
            case (state)
                IDLE: begin
                    if (data == 4'b1101)
                        state <= DETECT_START;
                end
                DETECT_START: begin
                    shift_ena <= 1;
                    counting <= 0;
                    state <= SHIFT_IN;
                end
                SHIFT_IN: begin
                    shift_ena <= 0;
                    counting <= 0;
                    state <= WAIT_COUNTING;
                end
                WAIT_COUNTING: begin
                    shift_ena <= 0;
                    counting <= 1;
                    if (done_counting)
                        state <= NOTIFY;
                end
                NOTIFY: begin
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 1;
                    state <= WAIT_ACK;
                end
                WAIT_ACK: begin
                    shift_ena <= 0;
                    counting <= 0;
                    if (ack)
                        state <= IDLE;
                end
            endcase
        end
    end 

endmodule
