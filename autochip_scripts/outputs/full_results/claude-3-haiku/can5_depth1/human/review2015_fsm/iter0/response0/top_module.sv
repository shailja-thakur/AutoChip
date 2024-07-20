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

localparam STATE_IDLE = 3'b000;
localparam STATE_START = 3'b001;
localparam STATE_SHIFT = 3'b010;
localparam STATE_COUNTING = 3'b011;
localparam STATE_DONE = 3'b100;

reg [2:0] state, next_state;
reg [3:0] pattern;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_IDLE;
        pattern <= 4'b0;
        shift_ena <= 1'b0;
        counting <= 1'b0;
        done <= 1'b0;
    end
    else begin
        state <= next_state;
        if (state == STATE_SHIFT) begin
            pattern <= {pattern[2:0], data};
        end
    end
end

always @(*) begin
    next_state = state;
    case (state)
        STATE_IDLE: begin
            if (pattern == 4'b1101) begin
                next_state = STATE_START;
            end
        end
        STATE_START: begin
            next_state = STATE_SHIFT;
            shift_ena = 1'b1;
        end
        STATE_SHIFT: begin
            if (shift_ena == 1'b1) begin
                shift_ena = 1'b0;
            end
            if (pattern == 4'b1101) begin
                next_state = STATE_IDLE;
            end
            else if (shift_ena == 1'b0) begin
                next_state = STATE_COUNTING;
                counting = 1'b1;
            end
        end
        STATE_COUNTING: begin
            if (done_counting) begin
                next_state = STATE_DONE;
                counting = 1'b0;
                done = 1'b1;
            end
        end
        STATE_DONE: begin
            if (ack) begin
                next_state = STATE_IDLE;
                done = 1'b0;
            end
        end
    endcase
end

endmodule
