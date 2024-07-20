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
    S_IDLE = 4'b0000,
    S_DETECT_1101 = 4'b0001,
    S_SHIFT_DURATION = 4'b0010,
    S_COUNTING = 4'b0011,
    S_WAIT_ACK = 4'b0100;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= S_IDLE;
        pattern <= 4'b0000;
        shift_ena <= 1'b0;
        counting <= 1'b0;
        done <= 1'b0;
    end
    else begin
        case (state)
            S_IDLE: begin
                if (data == 1'b1) begin
                    pattern <= {pattern[2:0], data};
                    if (pattern == 4'b1101) begin
                        state <= S_DETECT_1101;
                    end
                end
                else begin
                    pattern <= {pattern[2:0], data};
                end
            end
            S_DETECT_1101: begin
                shift_ena <= 1'b1;
                state <= S_SHIFT_DURATION;
            end
            S_SHIFT_DURATION: begin
                if (shift_ena) begin
                    shift_ena <= 1'b0;
                end
                else begin
                    state <= S_COUNTING;
                    counting <= 1'b1;
                end
            end
            S_COUNTING: begin
                if (done_counting) begin
                    counting <= 1'b0;
                    done <= 1'b1;
                    state <= S_WAIT_ACK;
                end
            end
            S_WAIT_ACK: begin
                if (ack) begin
                    done <= 1'b0;
                    state <= S_IDLE;
                end
            end
            default: begin
                state <= S_IDLE;
            end
        endcase
    end
end

endmodule
