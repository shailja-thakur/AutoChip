module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [1:0] state;
reg [1:0] byte_count;

always @(posedge clk) begin
    if (reset) begin
        state <= 0;
        byte_count <= 0;
        done <= 0;
    end
    else begin
        case (state)
            0: begin // Wait for first byte with in[3] = 1
                if (in[3]) begin
                    state <= 1;
                    byte_count <= 1;
                end
            end
            1: begin // Received first byte, waiting for second byte
                byte_count <= 2;
                state <= 2;
            end
            2: begin // Received second byte, waiting for third byte
                byte_count <= 3;
                if (byte_count == 3) begin
                    done <= 1; // Signal that a complete message has been received
                    state <= 0;
                    byte_count <= 0;
                end
                else begin
                    state <= 2;
                end
            end
            default: begin
                state <= 0;
                byte_count <= 0;
                done <= 0;
            end
        endcase
    end
end

endmodule
