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
wire [7:0] in_next;
reg [23:0] out_bytes_reg;
reg done_reg;

always @(posedge clk) begin
    if (reset) begin
        byte1 <= 8'h00;
        byte2 <= 8'h00;
        byte3 <= 8'h00;
        done_reg <= 1'b0;
        out_bytes_reg <= 24'h000000;
    end else begin
        byte1 <= in_next;
        byte2 <= byte1;
        byte3 <= byte2;
        out_bytes_reg <= {byte3, byte2, byte1};
        done_reg <= (byte3[3] == 1'b1);
    end
end

assign in_next = reset ? 8'h00 : in;

assign out_bytes = out_bytes_reg;
assign done = done_reg;

endmodule
