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
                 WAIT_COUNT = 4'b0011,
                 NOTIFY_USER = 4'b0100;

reg [3:0] state, next_state;
reg [3:0] pattern_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        pattern_reg <= 4'b0000;
    end
    else begin
        state <= next_state;
        pattern_reg <= {pattern_reg[2:0], data};
    end
end

always @(*) begin
    next_state = state;
    shift_ena = 1'b0;
    counting = 1'b0;
    done = 1'b0;

    case (state)
        IDLE: begin
            if (pattern_reg == 4'b1101) begin
                next_state = DETECT_PATTERN;
            end
        end

        DETECT_PATTERN: begin
            shift_ena = 1'b1;
            next_state = SHIFT_DURATION;
        end

        SHIFT_DURATION: begin
            shift_ena = 1'b1;
            if (pattern_reg[3:0] == 4'b0000) begin
                next_state = WAIT_COUNT;
            end
        end

        WAIT_COUNT: begin
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
