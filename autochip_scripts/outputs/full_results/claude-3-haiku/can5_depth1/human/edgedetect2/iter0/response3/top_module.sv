module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);

reg [7:0] in_d1;

always @(posedge clk) begin
    in_d1 <= in;
    anyedge <= in ^ in_d1;
end

endmodule
