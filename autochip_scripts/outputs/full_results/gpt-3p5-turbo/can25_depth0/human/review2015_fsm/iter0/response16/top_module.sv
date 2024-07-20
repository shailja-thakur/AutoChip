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

    // State definitions
    parameter IDLE = 0;
    parameter DETECT_PATTERN = 1;
    parameter SHIFT_ENA = 2;
    parameter COUNTING = 3;
    parameter DONE = 4;

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
                    shift_ena <= 1;
                end
                SHIFT_ENA: begin
                    state <= COUNTING;
                    shift_ena <= 0;
                    counting <= 1;
                end
                COUNTING: begin
                    if (done_counting) begin
                        state <= DONE;
                        counting <= 0;
                        done <= 1;
                    end
                end
                DONE: begin
                    if (ack) begin
                        state <= IDLE;
                        done <= 0;
                    end
                end
            endcase
        end
    end
endmodule
