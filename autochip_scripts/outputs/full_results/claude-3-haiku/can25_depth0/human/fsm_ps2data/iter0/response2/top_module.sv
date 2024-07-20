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
            0: begin // Waiting for start of message
                if (in[3]) begin
                    state <= 1;
                    byte_count <= 1;
                    out_bytes[23:16] <= in;
                end
            end
            1: begin // Receiving second byte
                out_bytes[15:8] <= in;
                byte_count <= 2;
                state <= 2;
            end
            2: begin // Receiving third byte
                out_bytes[7:0] <= in;
                byte_count <= 3;
                state <= 3;
                done <= 1;
            end
            3: begin // Done
                done <= 0;
                state <= 0;
                byte_count <= 0;
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
