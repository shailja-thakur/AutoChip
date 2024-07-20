module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

reg [1:0] state;
reg [7:0] byte1, byte2, byte3;

always @(posedge clk) begin
    if (reset) begin
        state <= 2'b00;
        byte1 <= 8'b0;
        byte2 <= 8'b0;
        byte3 <= 8'b0;
        done <= 0;
        out_bytes <= 24'b0;
    end else begin
        case (state)
            2'b00:
                if (in[3]) begin
                    state <= 2'b01;
                    byte1 <= in;
                end
            2'b01:
                begin
                byte2 <= in;
                state <= 2'b10;
                end
            2'b10:
                begin
                byte3 <= in;
                state <= 2'b11;
                end
            2'b11:
                begin
                done <= 1;
                out_bytes <= {byte3, byte2, byte1};
                state <= 2'b00;
                end
        endcase
    end
end

endmodule
