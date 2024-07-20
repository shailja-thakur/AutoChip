module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);

reg [7:0] reg_in;

always @(posedge clk) begin
    reg_in <= in;
end

always @(posedge clk) begin
    anyedge <= (in ^ reg_in) & in;
end

endmodule
