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

localparam [2:0] IDLE = 3'b000, DETECT_START = 3'b001, SHIFT_COUNT = 3'b010, COUNT = 3'b011, NOTIFY = 3'b100;

reg [2:0] state, next_state;
reg [3:0] pattern;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        pattern <= 4'b0000;
    end
    else begin
        state <= next_state;
        pattern <= {pattern[2:0], data};
    end
end

always @(*) begin
    next_state = state;
    shift_ena = 1'b0;
    counting = 1'b0;
    done = 1'b0;

    case (state)
        IDLE: begin
            if (pattern == 4'b1101) begin
                next_state = DETECT_START;
            end
        end
        DETECT_START: begin
            shift_ena = 1'b1;
            next_state = SHIFT_COUNT;
        end
        SHIFT_COUNT: begin
            shift_ena = 1'b1;
            if (pattern[3:0] == 4'b0000) begin
                next_state = COUNT;
            end
        end
        COUNT: begin
            counting = 1'b1;
            if (done_counting) begin
                next_state = NOTIFY;
            end
        end
        NOTIFY: begin
            done = 1'b1;
            if (ack) begin
                next_state = IDLE;
            end
        end
    endcase
end

endmodule
