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
parameter [3:0] IDLE = 0, DETECT_PATTERN = 1, SHIFT_TIMER = 2, COUNT = 3, NOTIFY = 4;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
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
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
            end
            DETECT_PATTERN: begin
                if (data == 1'b1) begin
                    state <= DETECT_PATTERN;
                end
                else if (data == 1'b0) begin
                    state <= SHIFT_TIMER;
                    shift_ena <= 1;
                end
                else begin
                    state <= IDLE;
                end
                counting <= 0;
                done <= 0;
            end
            SHIFT_TIMER: begin
                if (shift_ena == 1) begin
                    shift_ena <= 1;
                end
                else begin
                    shift_ena <= 0;
                    state <= COUNT;
                    counting <= 1;
                end
                done <= 0;
            end
            COUNT: begin
                if (done_counting == 1) begin
                    state <= NOTIFY;
                    counting <= 0;
                    done <= 1;
                end
                else begin
                    state <= COUNT;
                    counting <= 1;
                end
            end
            NOTIFY: begin
                if (ack == 1) begin
                    state <= IDLE;
                end
                else begin
                    state <= NOTIFY;
                end
                shift_ena <= 0;
                counting <= 0;
                done <= 1;
            end
            default: begin
                state <= IDLE;
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
            end
        endcase
    end
end

endmodule
