module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);

reg [7:0] prev_cycle;

always @(posedge clk) begin
    anyedge <= 0; // Reset anyedge to 0 at every clock cycle
    for (integer i = 0; i < 8; i = i + 1) begin
        if (in[i] & ~prev_cycle[i])
            anyedge[i] <= 1; // Set anyedge to 1 only for the specific bit where a 0 to 1 transition occurs
    end
    prev_cycle <= in;
end

endmodule
