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
    parameter IDLE = 2'b00;
    parameter DETECT_PATTERN = 2'b01;
    parameter SHIFT_IN = 2'b10;
    parameter WAIT_COUNTING = 2'b11;

    // Default assignments
    assign shift_ena = 0;
    assign counting = 0;
    assign done = 0;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            case(state)
                IDLE: begin
                    if (data == 4'b1101) begin
                        state <= DETECT_PATTERN;
                    end
                end
                DETECT_PATTERN: begin
                    shift_ena <= 1;
                    state <= SHIFT_IN;
                end
                SHIFT_IN: begin
                    shift_ena <= 0;
                    state <= WAIT_COUNTING;
                end
                WAIT_COUNTING: begin
                    counting <= 1;
                    if (done_counting) begin
                        state <= IDLE;
                        done <= 1;
                    end
                end
                default: begin
                    state <= IDLE;
                end
            endcase
        end
        if (ack) begin
            done <= 0;
        end
    end
endmodule
