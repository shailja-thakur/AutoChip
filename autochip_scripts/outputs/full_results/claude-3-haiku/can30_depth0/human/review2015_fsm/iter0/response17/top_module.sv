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

localparam [3:0] WAIT_PATTERN = 0,
                 SHIFT_DURATION = 1,
                 WAIT_COUNTER = 2,
                 NOTIFY_USER = 3,
                 WAIT_ACK = 4;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= WAIT_PATTERN;
        pattern <= 0;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
    end
    else begin
        case (state)
            WAIT_PATTERN: begin
                if (pattern == 4'b1101) begin
                    state <= SHIFT_DURATION;
                    pattern <= 0;
                    shift_ena <= 1;
                end
                else begin
                    pattern <= {pattern[2:0], data};
                    shift_ena <= 0;
                end
            end
            SHIFT_DURATION: begin
                if (shift_ena == 1) begin
                    pattern <= {pattern[2:0], data};
                    if (shift_ena == 1) begin
                        shift_ena <= 0;
                        state <= WAIT_COUNTER;
                        counting <= 1;
                    end
                end
            end
            WAIT_COUNTER: begin
                if (done_counting) begin
                    counting <= 0;
                    state <= NOTIFY_USER;
                    done <= 1;
                end
            end
            NOTIFY_USER: begin
                if (ack) begin
                    done <= 0;
                    state <= WAIT_PATTERN;
                end
            end
        endcase
    end
end

endmodule
