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

reg [3:0] state, next_state;
parameter IDLE = 4'd0, DETECT_PATTERN = 4'd1, SHIFT_ENABLE = 4'd2, WAIT_COUNTERS = 4'd3, NOTIFY_USER = 4'd4;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    shift_ena = 1'b0;
    counting = 1'b0;
    done = 1'b0;

    case (state)
        IDLE: begin
            if (data == 1'b1) begin
                next_state = DETECT_PATTERN;
            end
        end
        DETECT_PATTERN: begin
            if (data == 1'b1) begin
                // Shift in the pattern 1101
                if (data == 1'b1 && data == 1'b1 && data == 1'b0 && data == 1'b1) begin
                    next_state = SHIFT_ENABLE;
                end
            end
            else begin
                next_state = IDLE;
            end
        end
        SHIFT_ENABLE: begin
            shift_ena = 1'b1;
            if (shift_ena) begin
                next_state = WAIT_COUNTERS;
            end
        end
        WAIT_COUNTERS: begin
            counting = 1'b1;
            if (done_counting) begin
                next_state = NOTIFY_USER;
            end
        end
        NOTIFY_USER: begin
            done = 1'b1;
            if (ack) begin
                next_state = IDLE;
            end
        end
    endcase
end

endmodule
