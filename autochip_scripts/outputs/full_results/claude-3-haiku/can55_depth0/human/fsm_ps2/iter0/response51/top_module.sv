module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

parameter STATE_WAIT = 2'b00;
parameter STATE_BYTE1 = 2'b01;
parameter STATE_BYTE2 = 2'b10;
parameter STATE_BYTE3 = 2'b11;

reg [1:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_WAIT;
        done <= 0;
    end else begin
        case (state)
            STATE_WAIT: begin
                if (in[3]) begin
                    state <= STATE_BYTE1;
                end
                done <= 0;
            end
            STATE_BYTE1: begin
                state <= STATE_BYTE2;
                done <= 0;
            end
            STATE_BYTE2: begin
                state <= STATE_BYTE3;
                done <= 0;
            end
            STATE_BYTE3: begin
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
