module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [1:0] state;
reg [2:0] count;

always @(posedge clk) begin
    if (reset) begin
        state <= 0;
        count <= 0;
        done <= 0;
    end
    else begin
        case (state)
            2'b00: begin // Searching for first byte
                if (in[3]) begin
                    state <= 1;
                    count <= 1;
                end
            end
            2'b01: begin // Received first byte
                if (in[3]) begin
                    count <= 1;
                end
                else begin
                    count <= count + 1;
                    if (count == 3) begin
                        state <= 2;
                        done <= 1;
                    end
                    else begin
                        state <= 1;
                    end
                end
            end
            2'b10: begin // Received all 3 bytes
                done <= 0;
                state <= 0;
                count <= 0;
            end
        endcase
    end
end

endmodule
