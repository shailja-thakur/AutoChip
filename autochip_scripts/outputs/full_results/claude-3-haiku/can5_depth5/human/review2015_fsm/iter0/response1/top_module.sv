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

reg [3:0] state;
reg [3:0] pattern;

localparam [3:0] 
    IDLE = 4'b0000,
    DETECT_PATTERN = 4'b0001,
    SHIFT_DURATION = 4'b0010,
    COUNT_TIMER = 4'b0011,
    NOTIFY_USER = 4'b0100,
    WAIT_ACK = 4'b0101;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        shift_ena <= 1'b0;
        counting <= 1'b0;
        done <= 1'b0;
        pattern <= 4'b0000;
    end
    else begin
        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    pattern[3:0] <= {pattern[2:0], data};
                    state <= DETECT_PATTERN;
                end
                else begin
                    state <= IDLE;
                end
            end
            DETECT_PATTERN: begin
                if (pattern == 4'b1101) begin
                    state <= SHIFT_DURATION;
                    shift_ena <= 1'b1;
                end
                else if (data == 1'b1) begin
                    pattern[3:0] <= {pattern[2:0], data};
                end
                else begin
                    state <= IDLE;
                    shift_ena <= 1'b0;
                end
            end
            SHIFT_DURATION: begin
                if (shift_ena == 1'b1) begin
                    pattern[3:0] <= {pattern[2:0], data};
                    if (shift_ena == 1'b1) begin
                        shift_ena <= 1'b0;
                        state <= COUNT_TIMER;
                        counting <= 1'b1;
                    end
                end
            end
            COUNT_TIMER: begin
                if (done_counting == 1'b1) begin
                    state <= NOTIFY_USER;
                    counting <= 1'b0;
                    done <= 1'b1;
                end
            end
            NOTIFY_USER: begin
                if (ack == 1'b1) begin
                    state <= IDLE;
                    done <= 1'b0;
                end
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
