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

localparam [3:0] IDLE = 4'b0001,
                 DETECT_START = 4'b0010,
                 SHIFT_DURATION = 4'b0100,
                 COUNT = 4'b1000,
                 NOTIFY = 4'b0000;

reg [3:0] state, next_state;
reg [3:0] shift_count;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
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
            if (data == 1'b1) begin
                next_state = DETECT_START;
            end
        end

        DETECT_START: begin
            if (data == 1'b1) begin
                next_state = DETECT_START;
            end
            else if (data == 1'b0) begin
                next_state = SHIFT_DURATION;
                shift_count = 0;
                shift_ena = 1;
            end
        end

        SHIFT_DURATION: begin
            shift_ena = 1;
            shift_count = shift_count + 1;
            if (shift_count == 4) begin
                next_state = COUNT;
                counting = 1;
            end
        end

        COUNT: begin
            if (done_counting) begin
                next_state = NOTIFY;
                done = 1;
            end
        end

        NOTIFY: begin
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
