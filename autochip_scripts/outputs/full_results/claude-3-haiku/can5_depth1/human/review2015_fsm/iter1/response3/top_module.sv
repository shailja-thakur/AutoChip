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

localparam STATE_IDLE = 3'd0;
localparam STATE_DETECT_PATTERN = 3'd1;
localparam STATE_SHIFT_DURATION = 3'd2;
localparam STATE_COUNT = 3'd3;
localparam STATE_NOTIFY = 3'd4;
localparam STATE_ACK = 3'd5;

reg [2:0] state, next_state;
reg [3:0] pattern;
reg [3:0] duration;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_IDLE;
        pattern <= 4'b0;
        duration <= 4'b0;
    end
    else begin
        state <= next_state;
        pattern <= {pattern[2:0], data};
        if (state == STATE_SHIFT_DURATION) begin
            duration <= {duration[2:0], data};
        end
    end
end

always @(*) begin
    next_state = state;
    shift_ena = 1'b0;
    counting = 1'b0;
    done = 1'b0;

    case (state)
        STATE_IDLE: begin
            if (pattern == 4'b1101) begin
                next_state = STATE_DETECT_PATTERN;
            end
        end

        STATE_DETECT_PATTERN: begin
            shift_ena = 1'b1;
            next_state = STATE_SHIFT_DURATION;
        end

        STATE_SHIFT_DURATION: begin
            shift_ena = 1'b1;
            if (duration == 4'b0000) begin
                next_state = STATE_COUNT;
            end
        end

        STATE_COUNT: begin
            counting = 1'b1;
            if (done_counting) begin
                next_state = STATE_NOTIFY;
            end
        end

        STATE_NOTIFY: begin
            done = 1'b1;
            next_state = STATE_ACK;
        end

        STATE_ACK: begin
            if (ack) begin
                next_state = STATE_IDLE;
            end
        end
    endcase
end

endmodule
