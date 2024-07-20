module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

localparam STATE_WAIT = 0, STATE_MESSAGE_1 = 1, STATE_MESSAGE_2 = 2, STATE_MESSAGE_3 = 3;

reg [1:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_WAIT;
        done <= 0;
    end
    else begin
        case (state)
            STATE_WAIT: begin
                if (in[3]) begin
                    state <= STATE_MESSAGE_1;
                end
                done <= 0;
            end
            STATE_MESSAGE_1: begin
                state <= STATE_MESSAGE_2;
                done <= 0;
            end
            STATE_MESSAGE_2: begin
                state <= STATE_MESSAGE_3;
                done <= 0;
            end
            STATE_MESSAGE_3: begin
                state <= STATE_WAIT;
                done <= 1;
            end
            default: begin
                state <= STATE_WAIT;
                done <= 0;
            end
        endcase
    end
end

endmodule
