module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [1:0] state;
reg [2:0] byte_count;

always @(posedge clk) begin
    if (reset) begin
        state <= 0;
        byte_count <= 0;
        done <= 0;
    end
    else begin
        case (state)
            0: begin // Waiting for first byte
                if (in[3]) begin
                    state <= 1;
                    byte_count <= 1;
                end
            end
            1: begin // Received first byte
                byte_count <= byte_count + 1;
                if (byte_count == 2) begin
                    state <= 2;
                end
            end
            2: begin // Received second byte
                byte_count <= byte_count + 1;
                if (byte_count == 3) begin
                    state <= 0;
                    done <= 1;
                end
            end
        endcase
    end
end

endmodule
