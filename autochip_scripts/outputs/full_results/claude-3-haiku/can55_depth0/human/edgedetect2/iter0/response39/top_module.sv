module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);

reg [7:0] in_prev;

always @(posedge clk) begin
    in_prev <= in;
    anyedge <= (in ^ in_prev) & {8{1'b1}};
end

endmodule
