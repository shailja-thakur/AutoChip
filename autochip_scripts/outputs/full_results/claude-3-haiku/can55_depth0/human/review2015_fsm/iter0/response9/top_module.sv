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
parameter IDLE = 0, DETECT_1101 = 1, SHIFT_DURATION = 2, WAIT_COUNTING = 3, NOTIFY_USER = 4;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    state <= DETECT_1101;
                end else begin
                    state <= IDLE;
                end
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
            end
            DETECT_1101: begin
                if (data == 1'b1) begin
                    state <= DETECT_1101;
                end else if (data == 1'b0) begin
                    state <= DETECT_1101;
                end else if (data == 1'b1) begin
                    state <= DETECT_1101;
                end else if (data == 1'b0) begin
                    state <= SHIFT_DURATION;
                    shift_ena <= 1;
                end
            end
            SHIFT_DURATION: begin
                shift_ena <= 1;
                if (shift_ena == 1 && data != 1'b0) begin
                    state <= SHIFT_DURATION;
                end else if (shift_ena == 1 && data == 1'b0) begin
                    shift_ena <= 0;
                    state <= WAIT_COUNTING;
                    counting <= 1;
                end
            end
            WAIT_COUNTING: begin
                if (done_counting == 1'b1) begin
                    state <= NOTIFY_USER;
                    counting <= 0;
                    done <= 1;
                end else begin
                    state <= WAIT_COUNTING;
                end
            end
            NOTIFY_USER: begin
                if (ack == 1'b1) begin
                    state <= IDLE;
                    done <= 0;
                end else begin
                    state <= NOTIFY_USER;
                end
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
