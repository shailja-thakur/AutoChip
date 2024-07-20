module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [1:0] state;
localparam [1:0] 
    WAIT_FOR_START = 2'b00,
    RECV_BYTE1 = 2'b01,
    RECV_BYTE2 = 2'b10,
    RECV_BYTE3 = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_FOR_START;
        done <= 1'b0;
    end
    else begin
        case (state)
            WAIT_FOR_START: begin
                if (in[3]) begin
                    state <= RECV_BYTE1;
                end
                done <= 1'b0;
            end
            RECV_BYTE1: begin
                state <= RECV_BYTE2;
            end
            RECV_BYTE2: begin
                state <= RECV_BYTE3;
            end
            RECV_BYTE3: begin
                done <= 1'b1;
                state <= WAIT_FOR_START;
            end
        endcase
    end
end

endmodule
