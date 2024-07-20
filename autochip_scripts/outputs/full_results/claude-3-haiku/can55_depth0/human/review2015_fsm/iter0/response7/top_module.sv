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
                 DETECT_START = 4'b0001,
                 SHIFT_DURATION = 4'b0010,
                 COUNT_TIMER = 4'b0011,
                 NOTIFY_DONE = 4'b0100,
                 WAIT_ACK = 4'b0101;

reg [3:0] state, next_state;
reg [3:0] shift_count;

always @(posedge clk, posedge reset) begin
    if (reset) begin
        state <= IDLE;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
        shift_count <= 0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    shift_ena = 0;
    counting = 0;
    done = 0;

    case (state)
        IDLE: begin
            if (data == 1'b1) next_state = DETECT_START;
        end
        DETECT_START: begin
            if (data == 1'b1) next_state = DETECT_START;
            else if (data == 1'b0) next_state = SHIFT_DURATION;
            shift_ena = 1;
            shift_count = 0;
        end
        SHIFT_DURATION: begin
            shift_ena = 1;
            shift_count = shift_count + 1;
            if (shift_count == 4) next_state = COUNT_TIMER;
        end
        COUNT_TIMER: begin
            counting = 1;
            if (done_counting) next_state = NOTIFY_DONE;
        end
        NOTIFY_DONE: begin
            done = 1;
            next_state = WAIT_ACK;
        end
        WAIT_ACK: begin
            if (ack) next_state = IDLE;
        end
    endcase
end

endmodule
