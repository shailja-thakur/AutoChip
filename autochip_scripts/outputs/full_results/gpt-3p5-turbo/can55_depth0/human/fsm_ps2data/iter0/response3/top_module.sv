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
    end else begin
        case (state)
            0: begin // Discard bytes until in[3] is 1
                if (in[3] == 1) begin
                    state <= 1;
                end
            end
            1: begin // Received byte 1, wait for byte 2
                byte_count <= byte_count + 1;
                state <= 2;
                out_bytes[23:16] <= in;
            end
            2: begin // Received byte 2, wait for byte 3
                byte_count <= byte_count + 1;
                state <= 3;
                out_bytes[15:8] <= in;
            end
            3: begin // Received byte 3, signal completion of message
                byte_count <= byte_count + 1;
                state <= 0;
                out_bytes[7:0] <= in;
                done <= 1;
            end
        endcase
    end
end
endmodule
