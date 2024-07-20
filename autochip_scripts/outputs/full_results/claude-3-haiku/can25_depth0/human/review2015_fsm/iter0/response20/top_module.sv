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
parameter SEARCH = 4'd0, SHIFT = 4'd1, WAIT = 4'd2, NOTIFY = 4'd3;

always @(posedge clk) begin
    if (reset) begin
        state <= SEARCH;
        shift_ena <= 1'b0;
        counting <= 1'b0;
        done <= 1'b0;
    end
    else begin
        case (state)
            SEARCH: begin
                if (data == 1'b1) begin
                    state <= SHIFT;
                    shift_ena <= 1'b1;
                end
                else begin
                    state <= SEARCH;
                    shift_ena <= 1'b0;
                end
            end
            SHIFT: begin
                if (shift_ena == 1'b1) begin
                    if (data == 1'b0) begin
                        shift_ena <= 1'b0;
                        state <= WAIT;
                        counting <= 1'b1;
                    end
                    else begin
                        shift_ena <= 1'b1;
                    end
                end
                else begin
                    state <= SEARCH;
                end
            end
            WAIT: begin
                if (done_counting) begin
                    state <= NOTIFY;
                    counting <= 1'b0;
                    done <= 1'b1;
                end
                else begin
                    state <= WAIT;
                end
            end
            NOTIFY: begin
                if (ack) begin
                    state <= SEARCH;
                    done <= 1'b0;
                end
                else begin
                    state <= NOTIFY;
                end
            end
            default: begin
                state <= SEARCH;
            end
        endcase
    end
end

endmodule
