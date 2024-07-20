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
parameter WAIT_START = 4'd0,
          SHIFT_ENABLE = 4'd1,
          WAIT_COUNT = 4'd2,
          WAIT_ACK = 4'd3;

reg [3:0] pattern_cnt;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_START;
        shift_ena <= 1'b0;
        counting <= 1'b0;
        done <= 1'b0;
        pattern_cnt <= 4'b0;
    end
    else begin
        case (state)
            WAIT_START: begin
                if (data == 1'b1) begin
                    pattern_cnt <= 4'b1;
                    state <= SHIFT_ENABLE;
                end
                else begin
                    pattern_cnt <= 4'b0;
                end
            end
            SHIFT_ENABLE: begin
                if (pattern_cnt == 4'b1101) begin
                    shift_ena <= 1'b1;
                    pattern_cnt <= 4'b0;
                    state <= WAIT_COUNT;
                end
                else begin
                    if (data == 1'b1) begin
                        pattern_cnt <= pattern_cnt + 1'b1;
                    end
                    else begin
                        pattern_cnt <= 4'b0;
                    end
                end
            end
            WAIT_COUNT: begin
                shift_ena <= 1'b0;
                counting <= 1'b1;
                if (done_counting) begin
                    counting <= 1'b0;
                    done <= 1'b1;
                    state <= WAIT_ACK;
                end
            end
            WAIT_ACK: begin
                if (ack) begin
                    done <= 1'b0;
                    state <= WAIT_START;
                end
            end
        endcase
    end
end

endmodule
