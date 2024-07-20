module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);

reg [7:0] prev_cycle;
reg [7:0] curr_cycle;

always @(posedge clk) begin
    curr_cycle <= in;
    anyedge <= (curr_cycle & ~prev_cycle);
    prev_cycle <= curr_cycle;
end

endmodule
