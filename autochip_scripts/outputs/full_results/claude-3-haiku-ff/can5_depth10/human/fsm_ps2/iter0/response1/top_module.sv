module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

localparam [1:0] STATE_WAIT = 2'b00,
                 STATE_BYTE1 = 2'b01,
                 STATE_BYTE2 = 2'b10,
                 STATE_BYTE3 = 2'b11;

reg [1:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_WAIT;
        done <= 0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    case (state)
        STATE_WAIT:
            if (in[3]) begin
                next_state = STATE_BYTE1;
            end
            else begin
                next_state = STATE_WAIT;
            end
        STATE_BYTE1:
            next_state = STATE_BYTE2;
        STATE_BYTE2:
            next_state = STATE_BYTE3;
        STATE_BYTE3:
            begin
                next_state = STATE_WAIT;
                done = 1;
            end
        default:
            next_state = STATE_WAIT;
    endcase
end

endmodule
