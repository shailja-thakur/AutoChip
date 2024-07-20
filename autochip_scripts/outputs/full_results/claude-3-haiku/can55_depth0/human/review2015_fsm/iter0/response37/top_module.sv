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
    WAIT_PATTERN = 4'h0,
    SHIFT_DURATION = 4'h1,
    COUNT = 4'h2,
    NOTIFY = 4'h3,
    ACKNOWLEDGE = 4'h4;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= WAIT_PATTERN;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
        pattern <= 4'b0;
    end
    else begin
        case (state)
            WAIT_PATTERN: begin
                if (pattern == 4'b1101) begin
                    state <= SHIFT_DURATION;
                    shift_ena <= 1;
                    pattern <= 4'b0;
                end
                else begin
                    pattern <= {pattern[2:0], data};
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 0;
                end
            end
            SHIFT_DURATION: begin
                if (shift_ena == 1) begin
                    pattern <= {pattern[2:0], data};
                    if (shift_ena == 4) begin
                        shift_ena <= 0;
                        state <= COUNT;
                        counting <= 1;
                    end
                    else begin
                        shift_ena <= shift_ena + 1;
                    end
                end
            end
            COUNT: begin
                if (done_counting) begin
                    state <= NOTIFY;
                    counting <= 0;
                    done <= 1;
                end
            end
            NOTIFY: begin
                if (ack) begin
                    state <= WAIT_PATTERN;
                    done <= 0;
                end
            end
            default: state <= WAIT_PATTERN;
        endcase
    end
end

endmodule
