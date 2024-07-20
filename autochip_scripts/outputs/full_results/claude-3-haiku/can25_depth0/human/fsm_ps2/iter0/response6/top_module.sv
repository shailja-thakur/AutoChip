module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

localparam [1:0] 
    WAIT_FOR_BYTE1 = 2'b00,
    WAIT_FOR_BYTE2 = 2'b01,
    WAIT_FOR_BYTE3 = 2'b10;

reg [1:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_FOR_BYTE1;
        done <= 1'b0;
    end
    else begin
        case (state)
            WAIT_FOR_BYTE1: begin
                if (in[3]) begin
                    state <= WAIT_FOR_BYTE2;
                    done <= 1'b0;
                end
                else begin
                    state <= WAIT_FOR_BYTE1;
                    done <= 1'b0;
                end
            end
            WAIT_FOR_BYTE2: begin
                state <= WAIT_FOR_BYTE3;
                done <= 1'b0;
            end
            WAIT_FOR_BYTE3: begin
                state <= WAIT_FOR_BYTE1;
                done <= 1'b1;
            end
            default: begin
                state <= WAIT_FOR_BYTE1;
                done <= 1'b0;
            end
        endcase
    end
end

endmodule
