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
                 COUNT_TIMER = 4'd3,
                 NOTIFY_USER = 4'd4;

reg [3:0] state, next_state;
reg [3:0] bit_count;
reg [3:0] duration_count;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        duration_count <= 0;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            IDLE: begin
                bit_count <= 0;
            end
            DETECT_START: begin
                if (data) begin
                    bit_count <= bit_count + 1;
                    if (bit_count == 4'd3) begin
                        next_state <= SHIFT_DURATION;
                        bit_count <= 0;
                    end
                end
                else begin
                    bit_count <= 0;
                end
            end
            SHIFT_DURATION: begin
                shift_ena <= 1;
                bit_count <= bit_count + 1;
                if (bit_count == 4'd3) begin
                    next_state <= COUNT_TIMER;
                    shift_ena <= 0;
                    bit_count <= 0;
                end
            end
            COUNT_TIMER: begin
                counting <= 1;
                if (done_counting) begin
                    next_state <= NOTIFY_USER;
                    counting <= 0;
                end
            end
            NOTIFY_USER: begin
                done <= 1;
                if (ack) begin
                    next_state <= IDLE;
                    done <= 0;
                end
            end
        endcase
    end
end

always @* begin
    case (state)
        IDLE: next_state = DETECT_START;
        DETECT_START: next_state = (data && bit_count == 4'd3) ? SHIFT_DURATION : DETECT_START;
        SHIFT_DURATION: next_state = (bit_count == 4'd3) ? COUNT_TIMER : SHIFT_DURATION;
        COUNT_TIMER: next_state = done_counting ? NOTIFY_USER : COUNT_TIMER;
        NOTIFY_USER: next_state = ack ? IDLE : NOTIFY_USER;
        default: next_state = IDLE;
    endcase
end

endmodule
