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
            2'b00: begin // Searching for start of message
                if (in[3]) begin
                    state <= 1;
                    byte_count <= 1;
                    out_bytes[7:0] <= in;
                end
            end
            2'b01: begin // Receiving message
                if (byte_count == 3) begin
                    state <= 2;
                    done <= 1;
                end
                else begin
                    byte_count <= byte_count + 1;
                    case (byte_count)
                        1: out_bytes[15:8] <= in;
                        2: out_bytes[23:16] <= in;
                    endcase
                end
            end
            2'b10: begin // Output complete, wait for next message
                done <= 0;
                state <= 0;
            end
        endcase
    end
end

endmodule
