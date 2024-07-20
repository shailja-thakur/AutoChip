module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

localparam STATE_WAIT_BYTE1 = 2'b00,
          STATE_WAIT_BYTE2 = 2'b01,
          STATE_WAIT_BYTE3 = 2'b10;

reg [1:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_WAIT_BYTE1;
        done <= 1'b0;
    end
    else begin
        case (state)
            STATE_WAIT_BYTE1: begin
                if (in[3]) begin
                    state <= STATE_WAIT_BYTE2;
                end
                else begin
                    state <= STATE_WAIT_BYTE1;
                end
                done <= 1'b0;
            end
            STATE_WAIT_BYTE2: begin
                state <= STATE_WAIT_BYTE3;
                done <= 1'b0;
            end
            STATE_WAIT_BYTE3: begin
                state <= STATE_WAIT_BYTE1;
                done <= 1'b1;
            end
            default: begin
                state <= STATE_WAIT_BYTE1;
                done <= 1'b0;
            end
        endcase
    end
end

endmodule
