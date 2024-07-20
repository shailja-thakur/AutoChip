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

localparam IDLE = 2'b00;
localparam DETECT_PATTERN = 2'b01;
localparam SHIFT_DURATION = 2'b10;
localparam WAIT_COUNTING = 2'b11;

reg [1:0] state, next_state;
reg [3:0] pattern_shift;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        pattern_shift <= 0;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            IDLE: begin
                pattern_shift <= {pattern_shift[2:0], data};
                if (pattern_shift == 4'b1101) begin
                    next_state <= DETECT_PATTERN;
                end
                else begin
                    next_state <= IDLE;
                end
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
            end
            DETECT_PATTERN: begin
                pattern_shift <= {pattern_shift[2:0], data};
                shift_ena <= 1;
                if (pattern_shift == 4'b0000) begin
                    next_state <= SHIFT_DURATION;
                end
                else begin
                    next_state <= DETECT_PATTERN;
                end
                counting <= 0;
                done <= 0;
            end
            SHIFT_DURATION: begin
                shift_ena <= 1;
                if (pattern_shift == 4'b0000) begin
                    next_state <= WAIT_COUNTING;
                end
                else begin
                    next_state <= SHIFT_DURATION;
                end
                pattern_shift <= {pattern_shift[2:0], data};
                counting <= 0;
                done <= 0;
            end
            WAIT_COUNTING: begin
                shift_ena <= 0;
                counting <= 1;
                if (done_counting) begin
                    next_state <= IDLE;
                    done <= 1;
                end
                else begin
                    next_state <= WAIT_COUNTING;
                end
            end
        endcase
    end
end

endmodule
