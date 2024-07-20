module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

reg [1:0] state;
reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 2'b00;
        byte1 <= 8'h00;
        byte2 <= 8'h00;
        byte3 <= 8'h00;
        done <= 0;
        out_bytes <= 24'h000000;
    end else begin
        case (state)
            2'b00:
                if (in[3] == 1) begin
                    state <= 2'b01;
                    byte1 <= in;
                end
            2'b01:
                state <= 2'b10;
                byte2 <= in;
            2'b10:
                state <= 2'b11;
                byte3 <= in;
            2'b11:
                state <= 2'b00;
                byte1 <= in;
                byte2 <= 8'h00;
                byte3 <= 8'h00;
                done <= 1;
                out_bytes <= {byte3, byte2, byte1};
        endcase
    end
end

endmodule
