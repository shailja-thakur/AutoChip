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

localparam STATE_WAIT_START = 0,
          STATE_SHIFT_DURATION = 1,
          STATE_COUNT = 2,
          STATE_NOTIFY = 3;

reg [1:0] state, next_state;
reg [3:0] shift_count;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_WAIT_START;
        shift_count <= 0;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            STATE_WAIT_START: begin
                if (data == 1'b1 && shift_count == 4'd3) begin
                    next_state <= STATE_SHIFT_DURATION;
                    shift_count <= 0;
                end
                else if (data == 1'b1) begin
                    shift_count <= shift_count + 1;
                end
                else begin
                    shift_count <= 0;
                end
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
            end
            STATE_SHIFT_DURATION: begin
                if (shift_count == 4'd3) begin
                    next_state <= STATE_COUNT;
                    shift_count <= 0;
                end
                else begin
                    shift_count <= shift_count + 1;
                end
                shift_ena <= 1;
                counting <= 0;
                done <= 0;
            end
            STATE_COUNT: begin
                if (done_counting) begin
                    next_state <= STATE_NOTIFY;
                end
                shift_ena <= 0;
                counting <= 1;
                done <= 0;
            end
            STATE_NOTIFY: begin
                if (ack) begin
                    next_state <= STATE_WAIT_START;
                end
                shift_ena <= 0;
                counting <= 0;
                done <= 1;
            end
        endcase
    end
end

endmodule
