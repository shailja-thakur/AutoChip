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
    S_WAIT_START = 4'b0000,
    S_SHIFT_DURATION = 4'b0001,
    S_COUNT = 4'b0010,
    S_NOTIFY = 4'b0011;

always @(posedge clk) begin
    if (reset) begin
        state <= S_WAIT_START;
        shift_ena <= 1'b0;
        counting <= 1'b0;
        done <= 1'b0;
    end
    else begin
        case (state)
            S_WAIT_START: begin
                if (data == 1'b1 && data == 1'b1 && data == 1'b0 && data == 1'b1) begin
                    state <= S_SHIFT_DURATION;
                    shift_ena <= 1'b1;
                end
                else begin
                    shift_ena <= 1'b0;
                    counting <= 1'b0;
                    done <= 1'b0;
                end
            end
            S_SHIFT_DURATION: begin
                if (shift_ena) begin
                    shift_ena <= 1'b1;
                end
                else begin
                    shift_ena <= 1'b0;
                    state <= S_COUNT;
                    counting <= 1'b1;
                end
            end
            S_COUNT: begin
                if (done_counting) begin
                    counting <= 1'b0;
                    state <= S_NOTIFY;
                    done <= 1'b1;
                end
            end
            S_NOTIFY: begin
                if (ack) begin
                    done <= 1'b0;
                    state <= S_WAIT_START;
                end
            end
            default: state <= S_WAIT_START;
        endcase
    end
end

endmodule
