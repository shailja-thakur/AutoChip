module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [1:0] state;
parameter WAIT_START = 2'b00, RECEIVE_BYTE1 = 2'b01, RECEIVE_BYTE2 = 2'b10, RECEIVE_BYTE3 = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_START;
        done <= 0;
    end
    else begin
        case (state)
            WAIT_START: begin
                if (in[3]) begin
                    state <= RECEIVE_BYTE1;
                end
                else begin
                    state <= WAIT_START;
                    done <= 0;
                end
            end
            RECEIVE_BYTE1: begin
                state <= RECEIVE_BYTE2;
                done <= 0;
            end
            RECEIVE_BYTE2: begin
                state <= RECEIVE_BYTE3;
                done <= 0;
            end
            RECEIVE_BYTE3: begin
                state <= WAIT_START;
                done <= 1;
            end
        endcase
    end
end

endmodule
