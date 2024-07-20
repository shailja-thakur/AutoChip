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

parameter STATE_SEARCH = 3'd0;
parameter STATE_SHIFT = 3'd1;
parameter STATE_COUNT = 3'd2;
parameter STATE_NOTIFY = 3'd3;
parameter STATE_ACK = 3'd4;

reg [2:0] state, next_state;
reg [3:0] shift_count;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_SEARCH;
        shift_ena <= 1'b0;
        counting <= 1'b0;
        done <= 1'b0;
        shift_count <= 4'b0;
    end
    else begin
        state <= next_state;
        case (state)
            STATE_SEARCH: begin
                if ({data, shift_count[3:1]} == 4'b1101) begin
                    next_state <= STATE_SHIFT;
                    shift_ena <= 1'b1;
                    shift_count <= 4'b0001;
                end
                else begin
                    shift_count <= {data, shift_count[3:1]};
                end
            end
            STATE_SHIFT: begin
                if (shift_count == 4'b0100) begin
                    next_state <= STATE_COUNT;
                    shift_ena <= 1'b0;
                    counting <= 1'b1;
                end
                else begin
                    shift_count <= shift_count + 1'b1;
                end
            end
            STATE_COUNT: begin
                if (done_counting) begin
                    next_state <= STATE_NOTIFY;
                    counting <= 1'b0;
                    done <= 1'b1;
                end
            end
            STATE_NOTIFY: begin
                if (ack) begin
                    next_state <= STATE_SEARCH;
                    done <= 1'b0;
                end
            end
            STATE_ACK: begin
                // do nothing
            end
            default: begin
                next_state <= STATE_SEARCH;
            end
        endcase
    end
end

endmodule
