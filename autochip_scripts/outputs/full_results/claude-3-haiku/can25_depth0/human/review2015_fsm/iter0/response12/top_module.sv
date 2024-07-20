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
    S_WAIT_START = 4'd0,
    S_SHIFT_BITS = 4'd1,
    S_COUNTING = 4'd2,
    S_TIMER_DONE = 4'd3;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= S_WAIT_START;
        shift_ena <= 1'b0;
        counting <= 1'b0;
        done <= 1'b0;
        pattern <= 4'b0;
    end
    else begin
        case (state)
            S_WAIT_START: begin
                shift_ena <= 1'b0;
                counting <= 1'b0;
                done <= 1'b0;
                if (pattern == 4'b1101) begin
                    state <= S_SHIFT_BITS;
                    pattern <= 4'b0;
                end
                else begin
                    pattern <= {pattern[2:0], data};
                end
            end
            S_SHIFT_BITS: begin
                shift_ena <= 1'b1;
                if (pattern == 4'b1111) begin
                    state <= S_COUNTING;
                    shift_ena <= 1'b0;
                end
                else begin
                    pattern <= {pattern[2:0], data};
                end
            end
            S_COUNTING: begin
                shift_ena <= 1'b0;
                counting <= 1'b1;
                if (done_counting) begin
                    state <= S_TIMER_DONE;
                    counting <= 1'b0;
                    done <= 1'b1;
                end
            end
            S_TIMER_DONE: begin
                if (ack) begin
                    state <= S_WAIT_START;
                end
            end
            default: begin
                state <= S_WAIT_START;
            end
        endcase
    end
end

endmodule
