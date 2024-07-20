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

localparam STATE_WAIT_PATTERN = 0;
localparam STATE_SHIFT_DURATION = 1;
localparam STATE_COUNTING = 2;
localparam STATE_DONE = 3;

reg [1:0] state, next_state;
reg [3:0] pattern_shift;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_WAIT_PATTERN;
        pattern_shift <= 0;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
    end
    else begin
        state <= next_state;
        
        case (state)
            STATE_WAIT_PATTERN: begin
                pattern_shift <= {pattern_shift[2:0], data};
                if (pattern_shift == 4'b1101) begin
                    next_state <= STATE_SHIFT_DURATION;
                    shift_ena <= 1;
                end
                else begin
                    next_state <= STATE_WAIT_PATTERN;
                    shift_ena <= 0;
                end
                counting <= 0;
                done <= 0;
            end
            
            STATE_SHIFT_DURATION: begin
                if (shift_ena) begin
                    pattern_shift <= {pattern_shift[2:0], data};
                    shift_ena <= (pattern_shift != 4'b1111);
                end
                else begin
                    next_state <= STATE_COUNTING;
                    shift_ena <= 0;
                    counting <= 1;
                end
            end
            
            STATE_COUNTING: begin
                if (done_counting) begin
                    next_state <= STATE_DONE;
                    counting <= 0;
                    done <= 1;
                end
                else begin
                    next_state <= STATE_COUNTING;
                end
            end
            
            STATE_DONE: begin
                if (ack) begin
                    next_state <= STATE_WAIT_PATTERN;
                    done <= 0;
                end
                else begin
                    next_state <= STATE_DONE;
                end
            end
        endcase
    end
end

endmodule
