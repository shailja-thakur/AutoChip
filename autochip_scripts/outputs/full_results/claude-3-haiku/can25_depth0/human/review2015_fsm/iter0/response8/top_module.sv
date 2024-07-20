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
reg [3:0] pattern;

parameter IDLE = 4'd0,
          DETECT_PATTERN = 4'd1,
          SHIFT_DURATION = 4'd2,
          COUNTING = 4'd3,
          NOTIFY_USER = 4'd4,
          WAIT_ACK = 4'd5;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        pattern <= 4'b0;
        shift_ena <= 1'b0;
        counting <= 1'b0;
        done <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    pattern <= {pattern[2:0], data};
                    if (pattern == 4'b1101) begin
                        state <= DETECT_PATTERN;
                    end
                end
                else begin
                    pattern <= {pattern[2:0], data};
                end
            end
            DETECT_PATTERN: begin
                shift_ena <= 1'b1;
                state <= SHIFT_DURATION;
            end
            SHIFT_DURATION: begin
                if (shift_ena) begin
                    pattern <= {pattern[2:0], data};
                    shift_ena <= 1'b0;
                end
                else begin
                    state <= COUNTING;
                    counting <= 1'b1;
                end
            end
            COUNTING: begin
                if (done_counting) begin
                    counting <= 1'b0;
                    state <= NOTIFY_USER;
                    done <= 1'b1;
                end
            end
            NOTIFY_USER: begin
                if (ack) begin
                    done <= 1'b0;
                    state <= IDLE;
                end
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
