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

localparam [3:0] IDLE = 4'd0,
                 DETECT_START = 4'd1,
                 SHIFT_DURATION = 4'd2,
                 WAIT_COUNTING = 4'd3,
                 NOTIFY_TIMEOUT = 4'd4;

reg [3:0] state, next_state;
reg [3:0] shift_count;

always @(posedge clk) begin
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
        end
        SHIFT_DURATION: begin
            shift_ena = 1;
            shift_count = shift_count + 1;
            if (shift_count == 4'd4) next_state = WAIT_COUNTING;
        end
        WAIT_COUNTING: begin
            counting = 1;
            if (done_counting) next_state = NOTIFY_TIMEOUT;
        end
        NOTIFY_TIMEOUT: begin
            done = 1;
            if (ack) next_state = IDLE;
        end
    endcase
end

endmodule
