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
                 SHIFT_DURATION = 4'b0010,
                 COUNTING = 4'b0011,
                 NOTIFY_USER = 4'b0100,
                 WAIT_FOR_ACK = 4'b0101;

reg [3:0] state, next_state;
reg [3:0] pattern_shift;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        pattern_shift <= 4'b0;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            IDLE: begin
                pattern_shift <= 4'b0;
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
            end
            DETECT_PATTERN: begin
                pattern_shift <= {pattern_shift[2:0], data};
                if (pattern_shift == 4'b1101) begin
                    next_state <= SHIFT_DURATION;
                end
            end
            SHIFT_DURATION: begin
                shift_ena <= 1;
                if (pattern_shift[3] == 1) begin
                    next_state <= COUNTING;
                    shift_ena <= 0;
                end
            end
            COUNTING: begin
                counting <= 1;
                if (done_counting) begin
                    next_state <= NOTIFY_USER;
                    counting <= 0;
                end
            end
            NOTIFY_USER: begin
                done <= 1;
                next_state <= WAIT_FOR_ACK;
            end
            WAIT_FOR_ACK: begin
                if (ack) begin
                    next_state <= IDLE;
                end
            end
        endcase
    end
end

always @* begin
    case (state)
        IDLE: next_state = DETECT_PATTERN;
        DETECT_PATTERN: next_state = DETECT_PATTERN;
        SHIFT_DURATION: next_state = SHIFT_DURATION;
        COUNTING: next_state = COUNTING;
        NOTIFY_USER: next_state = NOTIFY_USER;
        WAIT_FOR_ACK: next_state = WAIT_FOR_ACK;
        default: next_state = IDLE;
    endcase
end

endmodule
