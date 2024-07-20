module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

reg [1:0] state;
parameter WAIT_START = 2'b00, RECEIVE_BYTE1 = 2'b01, RECEIVE_BYTE2 = 2'b10, RECEIVE_BYTE3 = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_START;
        done <= 1'b0;
        out_bytes <= 24'b0;
    end
    else begin
        case (state)
            WAIT_START: begin
                if (in[3]) begin
                    state <= RECEIVE_BYTE1;
                    out_bytes[23:16] <= in;
                end
                else begin
                    state <= WAIT_START;
                    done <= 1'b0;
                end
            end
            RECEIVE_BYTE1: begin
                state <= RECEIVE_BYTE2;
                out_bytes[15:8] <= in;
            end
            RECEIVE_BYTE2: begin
                state <= RECEIVE_BYTE3;
                out_bytes[7:0] <= in;
            end
            RECEIVE_BYTE3: begin
                state <= WAIT_START;
                done <= 1'b1;
            end
            default: begin
                state <= WAIT_START;
                done <= 1'b0;
                out_bytes <= 24'b0;
            end
        endcase
    end
end

endmodule
