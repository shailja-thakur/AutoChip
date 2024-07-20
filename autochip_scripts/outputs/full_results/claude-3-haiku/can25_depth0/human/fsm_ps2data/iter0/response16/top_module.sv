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
            0: // Discard bytes until the first byte of a message is found
                if (in[3]) begin
                    state <= 1;
                    out_bytes[7:0] <= in;
                    byte_count <= 1;
                end
            1: // Receive second byte of the message
                begin
                    state <= 2;
                    out_bytes[15:8] <= in;
                    byte_count <= 2;
                end
            2: // Receive third byte of the message
                begin
                    state <= 0;
                    out_bytes[23:16] <= in;
                    byte_count <= 0;
                    done <= 1;
                end
        endcase
    end
end

endmodule
