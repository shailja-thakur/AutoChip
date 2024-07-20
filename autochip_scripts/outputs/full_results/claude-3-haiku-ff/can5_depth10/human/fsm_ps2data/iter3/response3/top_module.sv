module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

reg [1:0] state;
reg [2:0] byte_count;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
        byte_count <= 0;
        out_bytes <= 0;
        done <= 0;
    end
    else begin
        case (state)
            0: begin // Searching for start of message
                if (in[3]) begin
                    state <= 1;
                    byte_count <= 1;
                    out_bytes[23:16] <= in;
                end
                else begin
                    state <= 0;
                    byte_count <= 0;
                    out_bytes <= 0;
                    done <= 0;
                end
            end
            1: begin // Receiving second byte
                byte_count <= byte_count + 1;
                out_bytes[15:8] <= in;
                if (byte_count == 2) begin
                    if (in[3]) begin
                        state <= 2;
                        byte_count <= 3;
                        out_bytes[7:0] <= in;
                        done <= 1;
                    end
                    else begin
                        state <= 2;
                    end
                end
                else begin
                    state <= 1;
                end
            end
            2: begin // Receiving third byte
                if (byte_count == 3) begin
                    state <= 0;
                    byte_count <= 0;
                    done <= 1;
                end
                else begin
                    state <= 2;
                end
            end
            default: begin
                state <= 0;
                byte_count <= 0;
                out_bytes <= 0;
                done <= 0;
            end
        endcase
    end
end

endmodule
