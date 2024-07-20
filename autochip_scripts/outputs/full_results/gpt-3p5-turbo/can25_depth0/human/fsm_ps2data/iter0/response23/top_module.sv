module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);

reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;

reg done_reg;
wire done;

always @(posedge clk) begin
    if (reset) begin
        byte1 <= 0;
        byte2 <= 0;
        byte3 <= 0;
        done_reg <= 0;
    end else begin
        byte1 <= byte2;
        byte2 <= byte3;
        byte3 <= in;
        done_reg <= (byte1[3] == 1 && byte2[3] == 0 && byte3[3] == 0);
    end
end

assign out_bytes = {byte1, byte2, byte3};
assign done = done_reg;

endmodule
