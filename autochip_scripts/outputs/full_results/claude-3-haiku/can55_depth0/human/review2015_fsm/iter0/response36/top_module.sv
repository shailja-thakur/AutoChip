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

reg [3:0] state;
parameter [3:0] 
    IDLE = 4'b0000,
    DETECT_PATTERN = 4'b0001,
    SHIFT_DURATION = 4'b0010,
    COUNT = 4'b0011,
    NOTIFY_USER = 4'b0100;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (data == 1'b1) state <= DETECT_PATTERN;
                else state <= IDLE;
            end
            DETECT_PATTERN: begin
                if (data == 1'b1) state <= DETECT_PATTERN;
                else if (data == 1'b0) state <= DETECT_PATTERN;
                else if ({data, 3'b000} == 4'b1101) state <= SHIFT_DURATION;
                else state <= IDLE;
            end
            SHIFT_DURATION: begin
                shift_ena <= 1;
                if (shift_ena) state <= COUNT;
                else state <= SHIFT_DURATION;
            end
            COUNT: begin
                shift_ena <= 0;
                counting <= 1;
                if (done_counting) state <= NOTIFY_USER;
                else state <= COUNT;
            end
            NOTIFY_USER: begin
                counting <= 0;
                done <= 1;
                if (ack) state <= IDLE;
                else state <= NOTIFY_USER;
            end
            default: state <= IDLE;
        endcase
    end
end

endmodule
