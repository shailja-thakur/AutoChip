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
                 COUNTING = 4'd3,
                 NOTIFY_DONE = 4'd4,
                 WAIT_ACK = 4'd5;

reg [3:0] state, next_state;
reg [3:0] shift_count;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
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
                shift_count = 0;
                next_state = SHIFT_DURATION;
            end
        end

        SHIFT_DURATION: begin
            shift_ena = 1'b1;
            shift_count = shift_count + 1;
            if (shift_count == 4'd4) begin
                next_state = COUNTING;
            end
        end

        COUNTING: begin
            counting = 1'b1;
            if (done_counting) begin
                next_state = NOTIFY_DONE;
            end
        end

        NOTIFY_DONE: begin
            done = 1'b1;
            next_state = WAIT_ACK;
        end

        WAIT_ACK: begin
            if (ack) begin
                next_state = IDLE;
            end
        end

        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
