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

localparam STATE_IDLE = 4'b0000;
localparam STATE_DETECT_PATTERN = 4'b0001;
localparam STATE_SHIFT_DURATION = 4'b0010;
localparam STATE_COUNTING = 4'b0011;
localparam STATE_DONE = 4'b0100;
localparam STATE_ACK = 4'b0101;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_IDLE;
        pattern <= 4'b0000;
        shift_ena <= 1'b0;
        counting <= 1'b0;
        done <= 1'b0;
    end else begin
        case (state)
            STATE_IDLE: begin
                if (data == 1'b1) begin
                    pattern[3:0] <= {pattern[2:0], data};
                    if (pattern == 4'b1101) begin
                        state <= STATE_DETECT_PATTERN;
                    end
                end else begin
                    pattern <= 4'b0000;
                end
            end
            STATE_DETECT_PATTERN: begin
                shift_ena <= 1'b1;
                state <= STATE_SHIFT_DURATION;
            end
            STATE_SHIFT_DURATION: begin
                if (shift_ena) begin
                    shift_ena <= 1'b0;
                end else begin
                    counting <= 1'b1;
                    state <= STATE_COUNTING;
                end
            end
            STATE_COUNTING: begin
                if (done_counting) begin
                    counting <= 1'b0;
                    done <= 1'b1;
                    state <= STATE_DONE;
                end
            end
            STATE_DONE: begin
                if (ack) begin
                    done <= 1'b0;
                    state <= STATE_IDLE;
                end
            end
            default: begin
                state <= STATE_IDLE;
            end
        endcase
    end
end

endmodule
