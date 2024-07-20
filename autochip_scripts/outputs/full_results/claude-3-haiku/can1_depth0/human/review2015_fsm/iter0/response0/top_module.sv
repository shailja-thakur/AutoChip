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

localparam STATE_IDLE = 3'd0;
localparam STATE_DETECT_START = 3'd1;
localparam STATE_SHIFT_DURATION = 3'd2;
localparam STATE_COUNT = 3'd3;
localparam STATE_NOTIFY = 3'd4;

reg [2:0] state, next_state;
reg [3:0] shift_count;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= STATE_IDLE;
        shift_count <= 0;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            STATE_IDLE: begin
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
            end
            STATE_DETECT_START: begin
                if (data == 1'b1) begin
                    shift_count <= 1;
                end
                else if (shift_count == 4'd4) begin
                    next_state <= STATE_SHIFT_DURATION;
                    shift_count <= 0;
                end
                else begin
                    shift_count <= shift_count + 1;
                end
            end
            STATE_SHIFT_DURATION: begin
                shift_ena <= 1;
                if (shift_count == 4'd4) begin
                    shift_ena <= 0;
                    next_state <= STATE_COUNT;
                end
                else begin
                    shift_count <= shift_count + 1;
                end
            end
            STATE_COUNT: begin
                counting <= 1;
                if (done_counting) begin
                    counting <= 0;
                    next_state <= STATE_NOTIFY;
                end
            end
            STATE_NOTIFY: begin
                done <= 1;
                if (ack) begin
                    done <= 0;
                    next_state <= STATE_IDLE;
                end
            end
        endcase
    end
end

endmodule
