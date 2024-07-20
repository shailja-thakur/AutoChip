module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [1:0] state;
parameter [1:0] WAIT = 2'b00, BYTE1 = 2'b01, BYTE2 = 2'b10, BYTE3 = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT;
        done <= 1'b0;
    end
    else begin
        case (state)
            WAIT: begin
                if (in[7:4] == 4'b1001) begin
                    state <= BYTE1;
                end
                else begin
                    state <= WAIT;
                end
                done <= 1'b0;
            end
            BYTE1: begin
                state <= BYTE2;
                done <= 1'b0;
            end
            BYTE2: begin
                state <= BYTE3;
                done <= 1'b0;
            end
            BYTE3: begin
                state <= WAIT;
                done <= 1'b1;
            end
        endcase
    end
end

endmodule
