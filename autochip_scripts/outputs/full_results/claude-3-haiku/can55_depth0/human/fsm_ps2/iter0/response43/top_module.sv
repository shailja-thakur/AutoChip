module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [1:0] state;
parameter [1:0] WAIT_BYTE1 = 2'b00,
                 WAIT_BYTE2 = 2'b01,
                 WAIT_BYTE3 = 2'b10;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_BYTE1;
        done <= 1'b0;
    end
    else begin
        case (state)
            WAIT_BYTE1: begin
                if (in[3]) begin // first byte of message
                    state <= WAIT_BYTE2;
                    done <= 1'b0;
                end
            end
            WAIT_BYTE2: begin
                state <= WAIT_BYTE3;
            end
            WAIT_BYTE3: begin
                state <= WAIT_BYTE1;
                done <= 1'b1; // signal message received
            end
            default: begin
                state <= WAIT_BYTE1;
                done <= 1'b0;
            end
        endcase
    end
end

endmodule
