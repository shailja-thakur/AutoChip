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
                 DETECT_PATTERN = 4'b0001,
                 SHIFT_DURATION = 4'b0010,
                 COUNT = 4'b0011,
                 NOTIFY = 4'b0100;

reg [3:0] state, next_state;
reg [3:0] shift_count;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        shift_count <= 0;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            IDLE: begin
                shift_count <= 0;
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
            end
            DETECT_PATTERN: begin
                if (data == 1'b1) begin
                    shift_count <= shift_count + 1;
                end
                else begin
                    shift_count <= 0;
                end
            end
            SHIFT_DURATION: begin
                if (shift_count < 4) begin
                    shift_ena <= 1;
                    shift_count <= shift_count + 1;
                end
                else begin
                    shift_ena <= 0;
                end
            end
            COUNT: begin
                counting <= 1;
            end
            NOTIFY: begin
                done <= 1;
            end
        endcase
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            if (data == 1'b1) begin
                next_state = DETECT_PATTERN;
            end
            else begin
                next_state = IDLE;
            end
        end
        DETECT_PATTERN: begin
            if (shift_count == 4 && data == 1'b1) begin
                next_state = SHIFT_DURATION;
            end
            else begin
                next_state = DETECT_PATTERN;
            end
        end
        SHIFT_DURATION: begin
            if (shift_count == 4) begin
                next_state = COUNT;
            end
            else begin
                next_state = SHIFT_DURATION;
            end
        end
        COUNT: begin
            if (done_counting) begin
                next_state = NOTIFY;
            end
            else begin
                next_state = COUNT;
            end
        end
        NOTIFY: begin
            if (ack) begin
                next_state = IDLE;
            end
            else begin
                next_state = NOTIFY;
            end
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
