module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);

reg [7:0] prev_cycle;
reg [7:0] in_prev_cycle;

always @(posedge clk) begin
    in_prev_cycle <= prev_cycle;
    prev_cycle <= in;
end

always @(posedge clk) begin
    anyedge <= (in & ~in_prev_cycle);
end

endmodule
