module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

localparam STATE_WAIT = 0;
localparam STATE_BYTE1 = 1;
localparam STATE_BYTE2 = 2;
localparam STATE_BYTE3 = 3;

reg [1:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_WAIT;
        done <= 1'b0;
    end
    else begin
        case (state)
            STATE_WAIT: begin
                if (in[3]) begin
                    state <= STATE_BYTE1;
                end
                else begin
                    state <= STATE_WAIT;
                    done <= 1'b0;
                end
            end
            STATE_BYTE1: begin
                state <= STATE_BYTE2;
                done <= 1'b0;
            end
            STATE_BYTE2: begin
                state <= STATE_BYTE3;
                done <= 1'b0;
            end
            STATE_BYTE3: begin
                state <= STATE_WAIT;
                done <= 1'b1;
            end
            default: begin
                state <= STATE_WAIT;
                done <= 1'b0;
            end
        endcase
    end
end

endmodule
