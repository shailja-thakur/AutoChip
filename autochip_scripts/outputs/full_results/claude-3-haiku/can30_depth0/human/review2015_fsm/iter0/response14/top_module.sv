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

localparam [3:0] IDLE = 4'd0, DETECT_START = 4'd1, SHIFT_DELAY = 4'd2, WAIT_TIMER = 4'd3, NOTIFY_USER = 4'd4;
reg [3:0] state, next_state;
reg [3:0] shift_count;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        shift_ena <= 1'b0;
        counting <= 1'b0;
        done <= 1'b0;
        shift_count <= 4'b0;
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
        IDLE: begin
            if (data == 1'b1) begin
                next_state = DETECT_START;
            end
        end
        DETECT_START: begin
            if (data == 1'b1) begin
                next_state = DETECT_START;
            end
            else if (data == 1'b0) begin
                next_state = SHIFT_DELAY;
                shift_ena = 1'b1;
                shift_count = 4'b0;
            end
        end
        SHIFT_DELAY: begin
            shift_ena = 1'b1;
            shift_count = shift_count + 4'b1;
            if (shift_count == 4'b0100) begin
                next_state = WAIT_TIMER;
                counting = 1'b1;
            end
        end
        WAIT_TIMER: begin
            if (done_counting) begin
                next_state = NOTIFY_USER;
                done = 1'b1;
            end
        end
        NOTIFY_USER: begin
            if (ack) begin
                next_state = IDLE;
            end
        end
    endcase
end

endmodule
