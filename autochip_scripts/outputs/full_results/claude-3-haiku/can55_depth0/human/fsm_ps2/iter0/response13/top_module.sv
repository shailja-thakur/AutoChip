module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

localparam WAIT_START = 0, BYTE1 = 1, BYTE2 = 2, BYTE3 = 3;
reg [1:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_START;
        done <= 0;
    end
    else begin
        case (state)
            WAIT_START: begin
                if (in[3]) begin
                    state <= BYTE1;
                end
                done <= 0;
            end
            BYTE1: begin
                state <= BYTE2;
                done <= 0;
            end
            BYTE2: begin
                state <= BYTE3;
                done <= 0;
            end
            BYTE3: begin
                state <= WAIT_START;
                done <= 1;
            end
        endcase
    end
end

endmodule
