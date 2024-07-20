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

localparam [2:0] 
    STATE_IDLE = 3'b000,
    STATE_DETECT_PATTERN = 3'b001,
    STATE_SHIFT_DURATION = 3'b010,
    STATE_COUNTING = 3'b011,
    STATE_NOTIFY = 3'b100;

reg [2:0] state, next_state;
reg [3:0] pattern_shift;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_IDLE;
        shift_ena <= 1'b0;
        counting <= 1'b0;
        done <= 1'b0;
        pattern_shift <= 4'b0;
    end
    else begin
        state <= next_state;

        case (state)
            STATE_IDLE: begin
                shift_ena <= 1'b0;
                counting <= 1'b0;
                done <= 1'b0;
                pattern_shift <= {pattern_shift[2:0], data};
            end
            STATE_DETECT_PATTERN: begin
                if (pattern_shift == 4'b1101) begin
                    shift_ena <= 1'b1;
                end
                else begin
                    shift_ena <= 1'b0;
                end
                counting <= 1'b0;
                done <= 1'b0;
                pattern_shift <= {pattern_shift[2:0], data};
            end
            STATE_SHIFT_DURATION: begin
                shift_ena <= 1'b1;
                counting <= 1'b0;
                done <= 1'b0;
                pattern_shift <= {pattern_shift[2:0], data};
            end
            STATE_COUNTING: begin
                shift_ena <= 1'b0;
                counting <= 1'b1;
                done <= 1'b0;
            end
            STATE_NOTIFY: begin
                shift_ena <= 1'b0;
                counting <= 1'b0;
                done <= 1'b1;
            end
        endcase
    end
end

always @* begin
    case (state)
        STATE_IDLE: next_state = (pattern_shift == 4'b1101) ? STATE_DETECT_PATTERN : STATE_IDLE;
        STATE_DETECT_PATTERN: next_state = (pattern_shift == 4'b1101) ? STATE_SHIFT_DURATION : STATE_IDLE;
        STATE_SHIFT_DURATION: next_state = (pattern_shift[3:0] == 4'b1111) ? STATE_COUNTING : STATE_SHIFT_DURATION;
        STATE_COUNTING: next_state = done_counting ? STATE_NOTIFY : STATE_COUNTING;
        STATE_NOTIFY: next_state = ack ? STATE_IDLE : STATE_NOTIFY;
        default: next_state = STATE_IDLE;
    endcase
end

endmodule
