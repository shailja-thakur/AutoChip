module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [2:0] state;
reg [7:0] byte1, byte2, byte3;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
        done <= 0;
    end else begin
        case (state)
            0: begin // Wait for byte with in[3]=1
                if (in[3] == 1) begin
                    state <= 1;
                    byte1 <= in;
                end
            end
            1: begin // Receive byte 2
                state <= 2;
                byte2 <= in;
            end
            2: begin // Receive byte 3
                state <= 0;
                byte3 <= in;
                done <= 1;
            end
            default: begin
                state <= 0;
                done <= 0;
            end
        endcase
    end
end

endmodule
