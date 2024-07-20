module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

localparam STATE_WAIT_START = 0,
          STATE_RECEIVE_BYTE1 = 1,
          STATE_RECEIVE_BYTE2 = 2,
          STATE_RECEIVE_BYTE3 = 3;

reg [1:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_WAIT_START;
        done <= 0;
    end
    else begin
        case (state)
            STATE_WAIT_START: begin
                if (in[3]) begin
                    state <= STATE_RECEIVE_BYTE1;
                end
                done <= 0;
            end
            STATE_RECEIVE_BYTE1: begin
                state <= STATE_RECEIVE_BYTE2;
            end
            STATE_RECEIVE_BYTE2: begin
                state <= STATE_RECEIVE_BYTE3;
            end
            STATE_RECEIVE_BYTE3: begin
                done <= 1;
                state <= STATE_WAIT_START;
            end
        endcase
    end
end

endmodule
