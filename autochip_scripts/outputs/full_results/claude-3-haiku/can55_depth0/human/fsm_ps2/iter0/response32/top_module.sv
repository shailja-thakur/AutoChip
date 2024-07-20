module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

localparam STATE_WAIT_START = 2'b00;
localparam STATE_RECV_BYTE1 = 2'b01;
localparam STATE_RECV_BYTE2 = 2'b10;
localparam STATE_RECV_BYTE3 = 2'b11;

reg [1:0] state, next_state;
reg [2:0] byte_count;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_WAIT_START;
        byte_count <= 0;
        done <= 0;
    end
    else begin
        state <= next_state;
        if (state == STATE_RECV_BYTE3) begin
            done <= 1;
        end
        else begin
            done <= 0;
        end
    end
end

always @(*) begin
    case (state)
        STATE_WAIT_START: begin
            if (in[7]) begin
                next_state = STATE_RECV_BYTE1;
                byte_count = 1;
            end
            else begin
                next_state = STATE_WAIT_START;
                byte_count = 0;
            end
        end
        STATE_RECV_BYTE1: begin
            next_state = STATE_RECV_BYTE2;
            byte_count = 2;
        end
        STATE_RECV_BYTE2: begin
            next_state = STATE_RECV_BYTE3;
            byte_count = 3;
        end
        STATE_RECV_BYTE3: begin
            next_state = STATE_WAIT_START;
            byte_count = 0;
        end
        default: begin
            next_state = STATE_WAIT_START;
            byte_count = 0;
        end
    endcase
end

endmodule
