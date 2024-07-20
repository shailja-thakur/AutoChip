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

localparam [3:0] STATE_IDLE = 4'b0000,
                 STATE_DETECT_START = 4'b0001,
                 STATE_SHIFT_DURATION = 4'b0010,
                 STATE_COUNT_TIMER = 4'b0011,
                 STATE_NOTIFY_DONE = 4'b0100,
                 STATE_WAIT_ACK = 4'b0101;

reg [3:0] state, next_state;
reg [3:0] shift_count;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= STATE_IDLE;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    shift_ena = 1'b0;
    counting = 1'b0;
    done = 1'b0;

    case (state)
        STATE_IDLE: begin
            if (data == 1'b1) begin
                next_state = STATE_DETECT_START;
            end
        end

        STATE_DETECT_START: begin
            if (data == 1'b1) begin
                next_state = STATE_DETECT_START;
            end
            else if (data == 1'b0) begin
                shift_count = 4'b0000;
                next_state = STATE_SHIFT_DURATION;
            end
        end

        STATE_SHIFT_DURATION: begin
            shift_ena = 1'b1;
            shift_count = shift_count + 4'b0001;
            if (shift_count == 4'b0100) begin
                next_state = STATE_COUNT_TIMER;
            end
            else begin
                next_state = STATE_SHIFT_DURATION;
            end
        end

        STATE_COUNT_TIMER: begin
            counting = 1'b1;
            if (done_counting) begin
                next_state = STATE_NOTIFY_DONE;
            end
            else begin
                next_state = STATE_COUNT_TIMER;
            end
        end

        STATE_NOTIFY_DONE: begin
            done = 1'b1;
            next_state = STATE_WAIT_ACK;
        end

        STATE_WAIT_ACK: begin
            if (ack) begin
                next_state = STATE_IDLE;
            end
            else begin
                next_state = STATE_WAIT_ACK;
            end
        end

        default: begin
            next_state = STATE_IDLE;
        end
    endcase
end

endmodule
