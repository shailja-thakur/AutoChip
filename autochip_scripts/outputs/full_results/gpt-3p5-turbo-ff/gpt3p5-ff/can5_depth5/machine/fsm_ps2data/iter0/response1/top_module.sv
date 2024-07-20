module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

reg [1:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
        out_bytes <= 0;
        done <= 0;
    end else begin
        case (state)
            0: begin  // BYTE1
                if (in[2]) begin
                    state <= 1;  // BYTE2
                else
                    state <= 0;  // Stay in BYTE1
            end
            1: begin  // BYTE2
                state <= 2;  // BYTE3
            end
            2: begin  // BYTE3
                state <= 3;  // DONE
            end
            3: begin  // DONE
                if (in[2]) begin
                    state <= 1;  // BYTE2
                else
                    state <= 0;  // BYTE1
            end
        endcase
    end
end

always @(posedge clk) begin
    if (done) begin
        out_bytes <= out_bytes << 8;
        out_bytes[7:0] <= in;
    end
end

assign done = (state == 3);

endmodule
