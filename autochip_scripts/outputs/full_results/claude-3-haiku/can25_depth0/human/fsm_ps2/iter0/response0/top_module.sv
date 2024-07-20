module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [1:0] state;
parameter WAIT_START = 2'b00, RECV_BYTE1 = 2'b01, RECV_BYTE2 = 2'b10, RECV_BYTE3 = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_START;
        done <= 1'b0;
    end
    else begin
        case (state)
            WAIT_START: begin
                if (in[3]) begin
                    state <= RECV_BYTE1;
                    done <= 1'b0;
                end
                else begin
                    state <= WAIT_START;
                    done <= 1'b0;
                end
            end
            RECV_BYTE1: begin
                state <= RECV_BYTE2;
                done <= 1'b0;
            end
            RECV_BYTE2: begin
                state <= RECV_BYTE3;
                done <= 1'b0;
            end
            RECV_BYTE3: begin
                state <= WAIT_START;
                done <= 1'b1;
            end
            default: begin
                state <= WAIT_START;
                done <= 1'b0;
            end
        endcase
    end
end

endmodule
