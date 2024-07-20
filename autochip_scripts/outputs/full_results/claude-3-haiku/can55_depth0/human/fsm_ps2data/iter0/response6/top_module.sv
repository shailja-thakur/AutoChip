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
    end
    else begin
        case (state)
            0: begin // Search for message start
                if (in[3]) begin
                    state <= 1;
                    byte_count <= 1;
                    out_bytes[23:16] <= in;
                end
            end
            1: begin // Receive second byte
                byte_count <= byte_count + 1;
                out_bytes[15:8] <= in;
                if (byte_count == 2) begin
                    state <= 2;
                end
            end
            2: begin // Receive third byte and signal done
                byte_count <= byte_count + 1;
                out_bytes[7:0] <= in;
                if (byte_count == 3) begin
                    done <= 1;
                    state <= 0;
                    byte_count <= 0;
                end
            end
        endcase
    end
end

endmodule
