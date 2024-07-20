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

parameter IDLE = 0, DETECT = 1, SHIFT = 2, WAIT = 3, NOTIFY = 4;
reg [2:0] state, next_state;
reg [3:0] pattern;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        pattern <= 0;
    end
    else begin
        state <= next_state;
        pattern <= {pattern[2:0], data};
    end
end

always @(*) begin
    next_state = state;
    shift_ena = 0;
    counting = 0;
    done = 0;
    case (state)
        IDLE: begin
            if (pattern == 4'b1101) begin
                next_state = SHIFT;
            end
        end
        SHIFT: begin
            shift_ena = 1;
            if (pattern[3:0] == 4'b1111) begin
                next_state = WAIT;
            end
        end
        WAIT: begin
            counting = 1;
            if (done_counting) begin
                next_state = NOTIFY;
            end
        end
        NOTIFY: begin
            done = 1;
            if (ack) begin
                next_state = IDLE;
            end
        end
    endcase
end

endmodule
