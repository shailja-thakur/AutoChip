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
parameter IDLE = 4'd0, DETECT_PATTERN = 4'd1, SHIFT_DURATION = 4'd2, COUNT = 4'd3, NOTIFY = 4'd4, WAIT_ACK = 4'd5;

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
                else begin
                    state <= IDLE;
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
                    state <= COUNT;
                end
                counting <= 1'b0;
                done <= 1'b0;
            end
            COUNT: begin
                if (done_counting == 1'b1) begin
                    state <= NOTIFY;
                    counting <= 1'b0;
                end
                else begin
                    counting <= 1'b1;
                end
                shift_ena <= 1'b0;
                done <= 1'b0;
            end
            NOTIFY: begin
                done <= 1'b1;
                state <= WAIT_ACK;
                shift_ena <= 1'b0;
                counting <= 1'b0;
            end
            WAIT_ACK: begin
                if (ack == 1'b1) begin
                    state <= IDLE;
                end
                else begin
                    state <= WAIT_ACK;
                end
                shift_ena <= 1'b0;
                counting <= 1'b0;
                done <= 1'b0;
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
