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

localparam STATE_SEARCH = 0, STATE_SHIFT = 1, STATE_COUNT = 2, STATE_NOTIFY = 3;
reg [1:0] state, next_state;
reg [3:0] shift_count;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_SEARCH;
        shift_count <= 0;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            STATE_SEARCH: begin
                if (data == 1'b1 && shift_count == 4'd0) begin
                    shift_count <= 1;
                end
                else if (data == 1'b1 && shift_count == 4'd1) begin
                    shift_count <= 2;
                end
                else if (data == 1'b0 && shift_count == 4'd2) begin
                    shift_count <= 3;
                end
                else if (data == 1'b1 && shift_count == 4'd3) begin
                    shift_count <= 4;
                    next_state <= STATE_SHIFT;
                end
                else begin
                    shift_count <= 0;
                end
            end
            STATE_SHIFT: begin
                shift_ena <= 1;
                if (shift_count == 4'd4) begin
                    shift_ena <= 0;
                    shift_count <= 0;
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
                    next_state <= STATE_SEARCH;
                end
            end
        endcase
    end
end

endmodule
