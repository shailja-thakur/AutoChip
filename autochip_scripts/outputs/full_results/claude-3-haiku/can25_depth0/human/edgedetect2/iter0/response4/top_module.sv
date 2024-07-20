module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);

reg [7:0] in_reg;

always @(posedge clk) begin
    in_reg <= in;
    anyedge <= (in ^ in_reg);
end

endmodule
