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
    COUNT_DELAY = 4'b0011,
    NOTIFY_USER = 4'b0100,
    WAIT_ACK = 4'b0101;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        shift_ena <= 1'b0;
        counting <= 1'b0;
        done <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    state <= DETECT_PATTERN;
                end
                else begin
                    state <= IDLE;
                end
                shift_ena <= 1'b0;
                counting <= 1'b0;
                done <= 1'b0;
            end
            DETECT_PATTERN: begin
                if (data == 1'b1) begin
                    state <= DETECT_PATTERN;
                end
                else if (data == 1'b0) begin
                    state <= SHIFT_DURATION;
                    shift_ena <= 1'b1;
                end
                counting <= 1'b0;
                done <= 1'b0;
            end
            SHIFT_DURATION: begin
                if (shift_ena == 1'b1) begin
                    shift_ena <= 1'b1;
                end
                else begin
                    shift_ena <= 1'b0;
                    state <= COUNT_DELAY;
                    counting <= 1'b1;
                end
                done <= 1'b0;
            end
            COUNT_DELAY: begin
                if (done_counting == 1'b1) begin
                    state <= NOTIFY_USER;
                    counting <= 1'b0;
                    done <= 1'b1;
                end
                else begin
                    state <= COUNT_DELAY;
                    counting <= 1'b1;
                    done <= 1'b0;
                end
            end
            NOTIFY_USER: begin
                if (ack == 1'b1) begin
                    state <= IDLE;
                    done <= 1'b0;
                end
                else begin
                    state <= NOTIFY_USER;
                    done <= 1'b1;
                end
                shift_ena <= 1'b0;
                counting <= 1'b0;
            end
            default: begin
                state <= IDLE;
                shift_ena <= 1'b0;
                counting <= 1'b0;
                done <= 1'b0;
            end
        endcase
    end
end

endmodule
