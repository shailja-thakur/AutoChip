module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;
reg [2:0] state;

always @(posedge clk) begin
    if (reset) begin
        byte1 <= 8'b0;
        byte2 <= 8'b0;
        byte3 <= 8'b0;
        state <= 0;
        done <= 0;
    end else begin
        case (state)
            0: begin // Wait for in[3] to be 1
                if (in[3] == 1) begin
                    byte1 <= in;
                    state <= 1;
                end
            end
            1: begin // Store byte 2
                byte2 <= in;
                state <= 2;
            end
            2: begin // Store byte 3 and indicate done
                byte3 <= in;
                done <= 1;
                state <= 0;
            end
        endcase
    end
end

endmodule
