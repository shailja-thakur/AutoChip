module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

parameter WAIT_FOR_START = 0, RECEIVE_BYTE1 = 1, RECEIVE_BYTE2 = 2, RECEIVE_BYTE3 = 3;
reg [1:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= WAIT_FOR_START;
        done <= 0;
    end
    else begin
        case (state)
            WAIT_FOR_START: begin
                if (in[3]) begin
                    state <= RECEIVE_BYTE1;
                    done <= 0;
                end
                else begin
                    state <= WAIT_FOR_START;
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
                state <= WAIT_FOR_START;
                done <= 1;
            end
            default: begin
                state <= WAIT_FOR_START;
                done <= 0;
            end
        endcase
    end
end

endmodule
