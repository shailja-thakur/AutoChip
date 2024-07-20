module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [1:0] state;
parameter WAIT_FOR_BYTE1 = 2'b00;
parameter WAIT_FOR_BYTE2 = 2'b01;
parameter WAIT_FOR_BYTE3 = 2'b10;

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
            end
            WAIT_FOR_BYTE2: begin
                state <= WAIT_FOR_BYTE3;
            end
            WAIT_FOR_BYTE3: begin
                state <= WAIT_FOR_BYTE1;
                done <= 1'b1;
            end
        endcase
    end
end

endmodule
