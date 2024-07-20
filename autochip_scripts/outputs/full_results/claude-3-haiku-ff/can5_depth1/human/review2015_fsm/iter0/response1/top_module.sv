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

reg [2:0] state, next_state;
reg [3:0] pattern_count;

localparam [2:0]
    IDLE = 3'b000,
    PATTERN = 3'b001,
    SHIFT = 3'b010,
    COUNT = 3'b011,
    NOTIFY = 3'b100;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        pattern_count <= 0;
    end
    else begin
        state <= next_state;
        if (state == SHIFT)
            pattern_count <= pattern_count + 1;
    end
end

always @(*) begin
    next_state = state;
    shift_ena = 0;
    counting = 0;
    done = 0;
    case (state)
        IDLE: begin
            if (data == 1'b1)
                next_state = PATTERN;
        end
        PATTERN: begin
            if (data == 1'b1 && pattern_count == 0)
                next_state = PATTERN;
            else if (data == 1'b0 && pattern_count == 1)
                next_state = PATTERN;
            else if (data == 1'b1 && pattern_count == 2)
                next_state = PATTERN;
            else if (data == 1'b0 && pattern_count == 3)
                next_state = SHIFT;
            else
                next_state = IDLE;
        end
        SHIFT: begin
            shift_ena = 1;
            if (pattern_count == 4)
                next_state = COUNT;
        end
        COUNT: begin
            counting = 1;
            if (done_counting)
                next_state = NOTIFY;
        end
        NOTIFY: begin
            done = 1;
            if (ack)
                next_state = IDLE;
        end
    endcase
end

endmodule
