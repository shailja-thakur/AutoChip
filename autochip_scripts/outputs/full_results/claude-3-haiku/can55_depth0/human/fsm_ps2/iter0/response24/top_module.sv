module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

localparam STATE_WAIT_FOR_START = 0;
localparam STATE_RECEIVE_BYTE1 = 1;
localparam STATE_RECEIVE_BYTE2 = 2;
localparam STATE_RECEIVE_BYTE3 = 3;

reg [1:0] state;
reg [7:0] byte1, byte2, byte3;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_WAIT_FOR_START;
        done <= 0;
    end
    else begin
        case (state)
            STATE_WAIT_FOR_START: begin
                if (in[3]) begin
                    byte1 <= in;
                    state <= STATE_RECEIVE_BYTE1;
                end
            end
            STATE_RECEIVE_BYTE1: begin
                byte2 <= in;
                state <= STATE_RECEIVE_BYTE2;
            end
            STATE_RECEIVE_BYTE2: begin
                byte3 <= in;
                state <= STATE_RECEIVE_BYTE3;
            end
            STATE_RECEIVE_BYTE3: begin
                done <= 1;
                state <= STATE_WAIT_FOR_START;
            end
            default: state <= STATE_WAIT_FOR_START;
        endcase
    end
end

endmodule
