module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

localparam STATE_WAIT_BYTE1 = 0;
localparam STATE_WAIT_BYTE2 = 1;
localparam STATE_WAIT_BYTE3 = 2;

reg [1:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_WAIT_BYTE1;
        done <= 0;
    end else begin
        case (state)
            STATE_WAIT_BYTE1: begin
                if (in[3]) begin
                    state <= STATE_WAIT_BYTE2;
                end
            end
            STATE_WAIT_BYTE2: begin
                state <= STATE_WAIT_BYTE3;
            end
            STATE_WAIT_BYTE3: begin
                done <= 1;
                state <= STATE_WAIT_BYTE1;
            end
        endcase
    end
end

endmodule
