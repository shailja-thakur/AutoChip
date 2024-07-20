module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [7:0] byte1_reg;
reg [7:0] byte2_reg;
reg [7:0] byte3_reg;
reg done_reg;

always @(posedge clk) begin
    if (reset) begin
        byte1_reg <= 8'b0;
        byte2_reg <= 8'b0;
        byte3_reg <= 8'b0;
        done_reg <= 1'b0;
    end else begin
        byte1_reg <= in;
        byte2_reg <= byte1_reg;
        byte3_reg <= byte2_reg;
        done_reg <= (byte3_reg[3] == 1'b1) ? 1'b1 : 1'b0;
    end
end

assign done = done_reg;

endmodule
