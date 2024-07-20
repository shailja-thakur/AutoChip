module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

localparam WAIT_BYTE1 = 2'd0;
localparam WAIT_BYTE2 = 2'd1;
localparam WAIT_BYTE3 = 2'd2;

reg [1:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_BYTE1;
        done <= 1'b0;
    end
    else begin
        case (state)
            WAIT_BYTE1: begin
                if (in[3]) begin
                    state <= WAIT_BYTE2;
                    done <= 1'b0;
                end
                else begin
                    state <= WAIT_BYTE1;
                    done <= 1'b0;
                end
            end
            WAIT_BYTE2: begin
                state <= WAIT_BYTE3;
                done <= 1'b0;
            end
            WAIT_BYTE3: begin
                state <= WAIT_BYTE1;
                done <= 1'b1;
            end
            default: begin
                state <= WAIT_BYTE1;
                done <= 1'b0;
            end
        endcase
    end
end

endmodule
