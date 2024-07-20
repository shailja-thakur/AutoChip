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
parameter WAIT_START = 0, DETECT_START = 1, SHIFT_DURATION = 2, COUNTING = 3, WAIT_ACK = 4;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= WAIT_START;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
    end
    else begin
        case (state)
            WAIT_START: begin
                if (data == 1'b1) begin
                    state <= DETECT_START;
                end
                else begin
                    state <= WAIT_START;
                end
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
            end
            DETECT_START: begin
                if (data == 1'b1) begin
                    state <= DETECT_START;
                end
                else if (data == 1'b0) begin
                    state <= SHIFT_DURATION;
                    shift_ena <= 1;
                end
                else begin
                    state <= WAIT_START;
                end
                counting <= 0;
                done <= 0;
            end
            SHIFT_DURATION: begin
                if (shift_ena == 1) begin
                    shift_ena <= 0;
                end
                else begin
                    state <= COUNTING;
                    counting <= 1;
                end
                done <= 0;
            end
            COUNTING: begin
                if (done_counting == 1) begin
                    state <= WAIT_ACK;
                    counting <= 0;
                    done <= 1;
                end
                else begin
                    state <= COUNTING;
                end
            end
            WAIT_ACK: begin
                if (ack == 1) begin
                    state <= WAIT_START;
                end
                else begin
                    state <= WAIT_ACK;
                end
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
            end
            default: begin
                state <= WAIT_START;
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
            end
        endcase
    end
end

endmodule
