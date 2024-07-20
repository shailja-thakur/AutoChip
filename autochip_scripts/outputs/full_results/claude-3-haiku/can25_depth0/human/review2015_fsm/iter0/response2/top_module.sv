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

localparam [3:0] 
    IDLE = 4'b0000,
    DETECT_PATTERN = 4'b0001,
    SHIFT_DURATION = 4'b0010,
    COUNT_DELAY = 4'b0011,
    NOTIFY_USER = 4'b0100,
    WAIT_ACK = 4'b0101;

reg [3:0] state, next_state;
reg [3:0] pattern_count;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        pattern_count <= 0;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            IDLE: begin
                pattern_count <= 0;
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
            end
            DETECT_PATTERN: begin
                if (data == 1'b1) begin
                    pattern_count <= pattern_count + 1;
                end
                else begin
                    pattern_count <= 0;
                end
                if (pattern_count == 4'd4) begin
                    pattern_count <= 0;
                end
            end
            SHIFT_DURATION: begin
                shift_ena <= 1;
            end
            COUNT_DELAY: begin
                shift_ena <= 0;
                counting <= 1;
                if (done_counting) begin
                    counting <= 0;
                end
            end
            NOTIFY_USER: begin
                done <= 1;
            end
            WAIT_ACK: begin
                done <= 0;
                if (ack) begin
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 0;
                end
            end
        endcase
    end
end

always @* begin
    case (state)
        IDLE: next_state = DETECT_PATTERN;
        DETECT_PATTERN: begin
            if (pattern_count == 4'd4) begin
                next_state = SHIFT_DURATION;
            end
            else begin
                next_state = DETECT_PATTERN;
            end
        end
        SHIFT_DURATION: next_state = COUNT_DELAY;
        COUNT_DELAY: begin
            if (done_counting) begin
                next_state = NOTIFY_USER;
            end
            else begin
                next_state = COUNT_DELAY;
            end
        end
        NOTIFY_USER: next_state = WAIT_ACK;
        WAIT_ACK: begin
            if (ack) begin
                next_state = IDLE;
            end
            else begin
                next_state = WAIT_ACK;
            end
        end
        default: next_state = IDLE;
    endcase
end

endmodule
