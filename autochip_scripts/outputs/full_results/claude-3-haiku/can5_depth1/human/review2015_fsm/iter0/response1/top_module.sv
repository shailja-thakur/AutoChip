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

localparam [3:0] WAIT_PATTERN = 4'b0000,
                 SHIFT_DURATION = 4'b0001,
                 WAIT_COUNTER = 4'b0010,
                 NOTIFY_USER = 4'b0011,
                 WAIT_ACK = 4'b0100;

reg [3:0] state, next_state;
reg [3:0] pattern;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= WAIT_PATTERN;
        pattern <= 4'b0;
        shift_ena <= 1'b0;
        counting <= 1'b0;
        done <= 1'b0;
    end
    else begin
        state <= next_state;
        case (state)
            WAIT_PATTERN: begin
                pattern <= {pattern[2:0], data};
                if (pattern == 4'b1101) begin
                    next_state <= SHIFT_DURATION;
                    shift_ena <= 1'b1;
                end
                else begin
                    next_state <= WAIT_PATTERN;
                    shift_ena <= 1'b0;
                end
                counting <= 1'b0;
                done <= 1'b0;
            end
            SHIFT_DURATION: begin
                pattern <= {pattern[2:0], data};
                if (shift_ena) begin
                    shift_ena <= 1'b1;
                end
                else begin
                    shift_ena <= 1'b0;
                    next_state <= WAIT_COUNTER;
                    counting <= 1'b1;
                end
            end
            WAIT_COUNTER: begin
                if (done_counting) begin
                    next_state <= NOTIFY_USER;
                    counting <= 1'b0;
                    done <= 1'b1;
                end
                else begin
                    next_state <= WAIT_COUNTER;
                end
            end
            NOTIFY_USER: begin
                if (ack) begin
                    next_state <= WAIT_PATTERN;
                end
                else begin
                    next_state <= NOTIFY_USER;
                end
            end
            default: begin
                next_state <= WAIT_PATTERN;
            end
        endcase
    end
end

endmodule
