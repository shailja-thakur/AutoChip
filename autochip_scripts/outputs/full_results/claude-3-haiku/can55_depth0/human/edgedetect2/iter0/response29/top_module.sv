module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);

reg [7:0] in_delay;

always @(posedge clk) begin
    in_delay <= in;
    anyedge <= (in ^ in_delay) & 8'b11111111;
end

endmodule
