module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [1:0] state;
parameter [1:0] WAIT_FOR_START = 2'd0,
                AWAIT_BYTE2 = 2'd1,
                AWAIT_BYTE3 = 2'd2;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_FOR_START;
        done <= 1'b0;
    end
    else begin
        case (state)
            WAIT_FOR_START: begin
                // Wait for the first byte of a message
                if (in[3]) begin
                    state <= AWAIT_BYTE2;
                    done <= 1'b0;
                end
                else begin
                    state <= WAIT_FOR_START;
                    done <= 1'b0;
                end
            end
            AWAIT_BYTE2: begin
                // Wait for the second byte of a message
                state <= AWAIT_BYTE3;
                done <= 1'b0;
            end
            AWAIT_BYTE3: begin
                // Wait for the third byte of a message
                state <= WAIT_FOR_START;
                done <= 1'b1;
            end
            default: begin
                state <= WAIT_FOR_START;
                done <= 1'b0;
            end
        endcase
    end
end

endmodule
