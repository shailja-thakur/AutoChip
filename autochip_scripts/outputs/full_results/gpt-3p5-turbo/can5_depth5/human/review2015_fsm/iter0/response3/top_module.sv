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
    parameter IDLE = 1'b0;
    parameter DETECT_PATTERN = 1'b1;
    parameter SHIFT = 1'b1;

    reg [1:0] state;

    // Sequential logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_ena <= 1'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    if (data == 1'b1 && $fell(data)) begin
                        state <= DETECT_PATTERN;
                    end
                end
                DETECT_PATTERN: begin
                    if (data == 1'b1 && $fell(data)) begin
                        state <= SHIFT;
                        shift_ena <= 1'b1;
                        counting <= 1'b0;
                    end
                end
                SHIFT: begin
                    state <= SHIFT;
                    shift_ena <= 1'b1;
                    counting <= 1'b0;
                    if (done_counting) begin
                        done <= 1'b1;
                        if (ack) begin
                            state <= DETECT_PATTERN;
                            shift_ena <= 1'b0;
                            counting <= 1'b0;
                            done <= 1'b0;
                        end
                    end
                end
            endcase
        end
    end
endmodule
