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

localparam [3:0] IDLE = 4'b0000,
                 START_PATTERN = 4'b0001,
                 SHIFT_DURATION = 4'b0010,
                 COUNTING = 4'b0011,
                 NOTIFY = 4'b0100,
                 WAIT_ACK = 4'b0101;

reg [3:0] state, next_state;
reg [3:0] pattern;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        pattern <= 4'b0000;
        shift_ena <= 1'b0;
        counting <= 1'b0;
        done <= 1'b0;
    end
    else begin
        state <= next_state;
        case (state)
            IDLE: begin
                pattern <= {pattern[2:0], data};
                if (pattern == 4'b1101) begin
                    next_state <= START_PATTERN;
                end
                else begin
                    next_state <= IDLE;
                end
            end
            START_PATTERN: begin
                shift_ena <= 1'b1;
                next_state <= SHIFT_DURATION;
            end
            SHIFT_DURATION: begin
                shift_ena <= 1'b1;
                if (shift_ena == 1'b1 && pattern[3] == 1'b1) begin
                    next_state <= COUNTING;
                    shift_ena <= 1'b0;
                    counting <= 1'b1;
                end
                else begin
                    next_state <= SHIFT_DURATION;
                end
            end
            COUNTING: begin
                if (done_counting) begin
                    next_state <= NOTIFY;
                    counting <= 1'b0;
                    done <= 1'b1;
                end
                else begin
                    next_state <= COUNTING;
                end
            end
            NOTIFY: begin
                if (ack) begin
                    next_state <= IDLE;
                    done <= 1'b0;
                end
                else begin
                    next_state <= NOTIFY;
                end
            end
            default: next_state <= IDLE;
        endcase
    end
end

endmodule
