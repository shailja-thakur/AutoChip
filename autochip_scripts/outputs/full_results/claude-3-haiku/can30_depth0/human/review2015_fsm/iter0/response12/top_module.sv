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

parameter STATE_SEARCH = 3'b000;
parameter STATE_SHIFT  = 3'b001;
parameter STATE_COUNT  = 3'b010;
parameter STATE_NOTIFY = 3'b011;
parameter STATE_ACK    = 3'b100;

reg [2:0] state, next_state;
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
                if (data == 1'b1) begin
                    if ({data, data, data, data} == 4'b1101) begin
                        next_state <= STATE_SHIFT;
                        shift_count <= 0;
                    end
                    else begin
                        next_state <= STATE_SEARCH;
                    end
                end
                else begin
                    next_state <= STATE_SEARCH;
                end
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
            end

            STATE_SHIFT: begin
                shift_ena <= 1;
                shift_count <= shift_count + 1;
                if (shift_count == 4) begin
                    next_state <= STATE_COUNT;
                end
                else begin
                    next_state <= STATE_SHIFT;
                end
                counting <= 0;
                done <= 0;
            end

            STATE_COUNT: begin
                shift_ena <= 0;
                counting <= 1;
                if (done_counting) begin
                    next_state <= STATE_NOTIFY;
                end
                else begin
                    next_state <= STATE_COUNT;
                end
                done <= 0;
            end

            STATE_NOTIFY: begin
                shift_ena <= 0;
                counting <= 0;
                done <= 1;
                if (ack) begin
                    next_state <= STATE_SEARCH;
                end
                else begin
                    next_state <= STATE_NOTIFY;
                end
            end

            STATE_ACK: begin
                // This state is not used in the design
                next_state <= STATE_SEARCH;
            end

            default: begin
                next_state <= STATE_SEARCH;
            end
        endcase
    end
end

endmodule
