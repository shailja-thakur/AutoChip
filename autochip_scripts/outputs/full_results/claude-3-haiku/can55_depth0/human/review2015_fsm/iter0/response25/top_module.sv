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

localparam [3:0] WAIT_FOR_PATTERN = 4'd0,
                 SHIFT_DURATION   = 4'd1,
                 COUNT_TIMER      = 4'd2,
                 NOTIFY_USER      = 4'd3;

reg [3:0] state, next_state;
reg [3:0] pattern_shift_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_FOR_PATTERN;
        pattern_shift_reg <= 4'b0;
        shift_ena <= 1'b0;
        counting <= 1'b0;
        done <= 1'b0;
    end
    else begin
        state <= next_state;
        pattern_shift_reg <= {pattern_shift_reg[2:0], data};
    end
end

always @(*) begin
    next_state = state;
    shift_ena = 1'b0;
    counting = 1'b0;
    done = 1'b0;

    case (state)
        WAIT_FOR_PATTERN: begin
            if (pattern_shift_reg == 4'b1101) begin
                next_state = SHIFT_DURATION;
                shift_ena = 1'b1;
            end
        end
        SHIFT_DURATION: begin
            shift_ena = 1'b1;
            if (pattern_shift_reg == 4'b1111) begin
                next_state = COUNT_TIMER;
            end
        end
        COUNT_TIMER: begin
            counting = 1'b1;
            if (done_counting) begin
                next_state = NOTIFY_USER;
            end
        end
        NOTIFY_USER: begin
            done = 1'b1;
            if (ack) begin
                next_state = WAIT_FOR_PATTERN;
            end
        end
    endcase
end

endmodule
