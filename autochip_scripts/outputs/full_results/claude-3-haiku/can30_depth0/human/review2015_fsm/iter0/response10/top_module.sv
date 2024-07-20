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

localparam [3:0] IDLE = 0, DETECT_PATTERN = 1, SHIFT_BITS = 2, COUNT_DELAY = 3, NOTIFY_USER = 4;
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
        case (state)
            IDLE: begin
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
                if (data == 1'b1) begin
                    next_state <= DETECT_PATTERN;
                end
                else begin
                    next_state <= IDLE;
                end
            end
            DETECT_PATTERN: begin
                if (data == 1'b1) begin
                    next_state <= DETECT_PATTERN;
                end
                else if (data == 1'b0) begin
                    if (shift_count == 3) begin
                        next_state <= SHIFT_BITS;
                        shift_count <= 0;
                    end
                    else begin
                        next_state <= DETECT_PATTERN;
                        shift_count <= shift_count + 1;
                    end
                end
                else begin
                    next_state <= IDLE;
                    shift_count <= 0;
                end
            end
            SHIFT_BITS: begin
                shift_ena <= 1;
                if (shift_count == 3) begin
                    shift_ena <= 0;
                    next_state <= COUNT_DELAY;
                end
                else begin
                    shift_count <= shift_count + 1;
                    next_state <= SHIFT_BITS;
                end
            end
            COUNT_DELAY: begin
                counting <= 1;
                if (done_counting) begin
                    counting <= 0;
                    next_state <= NOTIFY_USER;
                end
                else begin
                    next_state <= COUNT_DELAY;
                end
            end
            NOTIFY_USER: begin
                done <= 1;
                if (ack) begin
                    done <= 0;
                    next_state <= IDLE;
                end
                else begin
                    next_state <= NOTIFY_USER;
                end
            end
            default: begin
                next_state <= IDLE;
            end
        endcase
    end
end

endmodule
