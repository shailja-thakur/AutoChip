module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [1:0] state;
reg [1:0] count;

always @(posedge clk) begin
    if (reset) begin
        state <= 0;
        count <= 0;
        done <= 0;
    end
    else begin
        case (state)
            0: begin // Waiting for first byte
                if (in[3]) begin
                    state <= 1;
                    count <= 1;
                end
            end
            1: begin // Received first byte
                if (count == 1) begin
                    count <= 2;
                end
                else if (count == 2) begin
                    count <= 3;
                end
                else if (count == 3) begin
                    done <= 1;
                    state <= 0;
                    count <= 0;
                end
            end
        endcase
    end
end

endmodule
