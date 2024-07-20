module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);

reg [7:0] prev_cycle;

always @(posedge clk) begin
    prev_cycle <= in;
end

always @* begin
    anyedge = (in ^ prev_cycle) & in;
end

endmodule
