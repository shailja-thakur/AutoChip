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
                 DETECT_PATTERN = 4'b0001,
                 SHIFT_ENABLE = 4'b0010,
                 COUNTING = 4'b0011,
                 NOTIFY_DONE = 4'b0100,
                 WAIT_ACK = 4'b0101;

reg [3:0] state, next_state;
reg [3:0] pattern_count;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    shift_ena = 0;
    counting = 0;
    done = 0;
    case (state)
        IDLE: begin
            if (data == 1'b1) begin
                next_state = DETECT_PATTERN;
                pattern_count = 0;
            end
        end
        DETECT_PATTERN: begin
            if (data == 1'b1 && pattern_count == 0) begin
                pattern_count = 1;
            end
            else if (data == 1'b0 && pattern_count == 1) begin
                pattern_count = 2;
            end
            else if (data == 1'b1 && pattern_count == 2) begin
                pattern_count = 3;
            end
            else if (data == 1'b0 && pattern_count == 3) begin
                next_state = SHIFT_ENABLE;
                pattern_count = 0;
            end
            else begin
                next_state = IDLE;
                pattern_count = 0;
            end
        end
        SHIFT_ENABLE: begin
            shift_ena = 1;
            if (pattern_count == 4) begin
                next_state = COUNTING;
                pattern_count = 0;
            end
            else begin
                pattern_count = pattern_count + 1;
            end
        end
        COUNTING: begin
            counting = 1;
            if (done_counting) begin
                next_state = NOTIFY_DONE;
            end
        end
        NOTIFY_DONE: begin
            done = 1;
            next_state = WAIT_ACK;
        end
        WAIT_ACK: begin
            if (ack) begin
                next_state = IDLE;
            end
        end
    endcase
end

endmodule
