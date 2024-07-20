module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

reg [1:0] state;
reg [2:0] count;
reg [7:0] byte1, byte2, byte3;

always @(posedge clk) begin
    if (reset) begin
        state <= 0;
        count <= 0;
        out_bytes <= 0;
        done <= 0;
    end
    else begin
        case (state)
            0: begin // Waiting for start of message
                if (in[3]) begin
                    byte1 <= in;
                    state <= 1;
                    count <= 1;
                end
            end
            1: begin // Receiving second byte
                byte2 <= in;
                count <= 2;
                state <= 2;
            end
            2: begin // Receiving third byte
                byte3 <= in;
                count <= 3;
                state <= 3;
            end
            3: begin // Assemble output and signal done
                out_bytes <= {byte1, byte2, byte3};
                done <= 1;
                state <= 0;
                count <= 0;
            end
        endcase
    end
end

endmodule
