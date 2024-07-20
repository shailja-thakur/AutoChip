module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

reg [1:0] state;
reg [2:0] byte_count;

always @(posedge clk) begin
    if (reset) begin
        state <= 0;
        byte_count <= 0;
        out_bytes <= 0;
        done <= 0;
    end else begin
        case (state)
            0: begin // Searching for start of message
                if (in[3]) begin
                    state <= 1;
                    byte_count <= 1;
                    out_bytes[23:16] <= in;
                end else begin
                    byte_count <= 0;
                    out_bytes <= 0;
                    done <= 0;
                end
            end
            1: begin // Receiving second byte
                byte_count <= 2;
                out_bytes[15:8] <= in;
                state <= 2;
            end
            2: begin // Receiving third byte
                byte_count <= 3;
                out_bytes[7:0] <= in;
                state <= 3;
                done <= 1;
            end
            3: begin // Message received, wait for next message
                done <= 0;
                if (!in[3]) begin
                    state <= 0;
                    byte_count <= 0;
                end
            end
        endcase
    end
end

endmodule
