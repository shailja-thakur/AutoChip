module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

parameter WAIT_MSG = 0, RECV_BYTE1 = 1, RECV_BYTE2 = 2, RECV_BYTE3 = 3;
reg [1:0] state;
reg [1:0] count;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_MSG;
        count <= 0;
        done <= 0;
    end
    else begin
        case (state)
            WAIT_MSG: begin
                if (in[3]) begin // First byte of message
                    state <= RECV_BYTE1;
                    count <= 1;
                end
                else begin
                    state <= WAIT_MSG;
                    count <= 0;
                    done <= 0;
                end
            end
            RECV_BYTE1: begin
                state <= RECV_BYTE2;
                count <= 2;
            end
            RECV_BYTE2: begin
                state <= RECV_BYTE3;
                count <= 3;
            end
            RECV_BYTE3: begin
                state <= WAIT_MSG;
                count <= 0;
                done <= 1; // Signal receipt of a complete message
            end
        endcase
    end
end

endmodule
