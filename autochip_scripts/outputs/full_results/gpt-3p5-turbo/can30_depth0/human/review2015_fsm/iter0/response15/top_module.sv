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
    parameter DETECT_PATTERN = 1;
    parameter SHIFT_ENA = 2;
    parameter WAIT_COUNTING = 3;
    parameter NOTIFY_DONE = 4;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (data == 4'b1101) begin
                        state <= DETECT_PATTERN;
                    end
                end
                DETECT_PATTERN: begin
                    state <= SHIFT_ENA;
                end
                SHIFT_ENA: begin
                    shift_ena <= 1;
                    state <= WAIT_COUNTING;
                end
                WAIT_COUNTING: begin
                    shift_ena <= 0;
                    counting <= 1;
                    if (done_counting) begin
                        state <= NOTIFY_DONE;
                    end
                end
                NOTIFY_DONE: begin
                    done <= 1;
                    counting <= 0;
                    if (ack) begin
                        state <= IDLE;
                    end
                end
            endcase
        end
    end
endmodule
