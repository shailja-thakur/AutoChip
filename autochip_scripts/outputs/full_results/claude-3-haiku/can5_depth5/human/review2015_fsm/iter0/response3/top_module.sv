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

parameter IDLE = 4'b0000;
parameter DETECT_PATTERN = 4'b0001;
parameter SHIFT_DURATION = 4'b0010;
parameter COUNTING = 4'b0011;
parameter NOTIFY = 4'b0100;
parameter WAIT_ACK = 4'b0101;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        pattern <= 4'b0000;
        shift_ena <= 1'b0;
        counting <= 1'b0;
        done <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    pattern[3:0] <= {pattern[2:0], data};
                    if (pattern == 4'b1101) begin
                        state <= DETECT_PATTERN;
                    end
                end
                else begin
                    pattern[3:0] <= {pattern[2:0], data};
                end
            end
            DETECT_PATTERN: begin
                shift_ena <= 1'b1;
                state <= SHIFT_DURATION;
            end
            SHIFT_DURATION: begin
                if (shift_ena) begin
                    pattern[3:0] <= {pattern[2:0], data};
                    if (shift_ena == 1'b1) begin
                        shift_ena <= 1'b0;
                    end
                end
                else begin
                    state <= COUNTING;
                    counting <= 1'b1;
                end
            end
            COUNTING: begin
                if (done_counting) begin
                    counting <= 1'b0;
                    state <= NOTIFY;
                    done <= 1'b1;
                end
            end
            NOTIFY: begin
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
